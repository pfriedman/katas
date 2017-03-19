require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  describe '.name' do
    let!(:user) { FactoryGirl.create(:user,
                                      first_name: 'Chuck',
                                      last_name: 'Berry',
                                      email: 'chuck@rocknroll.com',
                                      password: 'maybelline') }
    it 'concatenates the first_name and last_name' do
      expect(user.name).to eq('Chuck Berry')
    end
  end
end
