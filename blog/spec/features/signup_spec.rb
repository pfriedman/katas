require 'rails_helper'

describe 'Signing up', type: :feature do

  context 'as a new user' do
    before do
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    end

    describe 'creating an account' do
      let(:first_name) { 'John' }
      let(:last_name) { 'Lennon' }
      let(:email) { "#{Devise.friendly_token[0,20]}@test.com" }
      let(:password) { "#{Devise.friendly_token[0,20]}" }

      before do
        visit root_path
        click_link 'Login'
        click_link 'Sign up'
        fill_in 'user_first_name', with: first_name
        fill_in 'user_last_name', with: last_name
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password
        click_button 'Sign up'
      end

      it 'persists the user record' do
        user = User.first
        expect(user.email).to eq(email.downcase)
        expect(user.first_name).to eq(first_name)
        expect(user.last_name).to eq(last_name)
      end

      it 'redirects the user to the home page' do
        expect(current_path).to eq('/')
        expect(page).to have_content('Welcome! You have signed up successfully.')
        expect(page).to have_content('Ben Kinney Blog')
      end
    end

  end

end
