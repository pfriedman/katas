require 'rails_helper'

describe 'Blogging', type: :feature do

  context 'as a guest' do

    it 'shows the guest user links' do
      visit '/'
      expect(page).to have_content('Home')
      expect(page).to have_content('Login')
      expect(page).to_not have_content('New Post')
      expect(page).to_not have_content('My Account')
      expect(page).to_not have_content('Logout')
    end

  end

  context 'as a logged in user' do
    let(:title) { 'Blog Post Title' }
    let(:body) { 'Blog Post Body' }
    let(:comment) { 'What a Blog Post! Very interesting :)' }
    let!(:user) { FactoryGirl.create(:user,
                                      first_name: 'Duke',
                                      last_name: 'Ellington',
                                      email: 'duke@jazz.com',
                                      password: 'suitethings') }
    before(:each) do
      login_as(user, scope: :user)
    end

    it 'shows the logged in user links' do
      visit '/'
      expect(page).to have_content('Home')
      expect(page).to_not have_content('Login')
      expect(page).to have_content('New Post')
      expect(page).to have_content('My Account')
      expect(page).to have_content('Logout')
    end

    context 'creating a blog post' do
      before do
        expect(Post.count).to eq(0)
        expect(Comment.count).to eq(0)
        visit '/'
        click_link 'New Post'
        fill_in 'post_title', with: title
        fill_in 'post_body', with: body
        click_button 'Create Post'
      end

      it 'persists the post record' do
        expect(page).to have_content('Successfully created post!')
        expect(page).to have_content(title)
        expect(page).to have_content(body)
        expect(Post.count).to eq(1)
        expect(Post.first.comments.count).to eq(0)
      end

      describe 'commenting on the post' do
        it 'persists the comment record on the post' do
          expect(Comment.count).to eq(0)
          expect(page).to have_content('Comments')
          expect(page).to_not have_content(comment)

          fill_in 'comment_body', with: comment
          click_button 'Add Comment'

          expect(page).to have_content('Your comment was successfully posted!')
          expect(page).to have_content(comment)
          expect(Comment.count).to eq(1)
          expect(Post.first.comments.first).to eq(Comment.first)
        end
      end

    end

    context 'with errors' do
      before do
        visit '/'
        click_link 'New Post'
        click_button 'Create Post'
      end

      it 'notifies the user of a problem' do
        expect(page).to have_content('Error creating new post!')
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Body can't be blank")
      end
    end
  end
end
