require 'rails_helper'

RSpec.describe User, type: :model do
  it "has many todos" do
    expect(subject).to have_many(:todos)
  end

  it "has an email address" do
    expect(subject).to validate_presence_of(:email)
  end

  it "has a unique email address" do
    expect(subject).to validate_uniqueness_of(:email)
  end
end

# devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable, :validatable
#   validates :email, presence: true, email: true
#   has_many :todos