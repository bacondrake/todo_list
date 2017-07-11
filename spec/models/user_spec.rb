require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it "should have an email address" do
    expect(user.email).to_not be_nil
  end

  it "should have a password longer than 5 characters" do
    expect(user.password.length).to be >5
  end
end
