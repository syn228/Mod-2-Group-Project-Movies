require 'rails_helper'

RSpec.describe SessionsController do
  
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
end
