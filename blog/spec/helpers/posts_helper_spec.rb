require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  it 'is included in the helper object' do
    included_modules = (class << helper; self; end).send :included_modules
    expect(included_modules).to include(PostsHelper)
  end
end
