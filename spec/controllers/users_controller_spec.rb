require 'rails_helper'

RSpec.describe UsersController do
  before(:each) do
    User.create(
      username: "ian",
      password: "notapassword",
      password_confirmation: "notapassword"
    )
  end
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }

  before(:each) do
    expect (subject.current_user).to_not eq(nil)
  end
end
