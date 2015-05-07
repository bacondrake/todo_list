require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "belongs to user" do
    expect(subject).to belong_to(:user)
  end


  it "validates the presence of content" do
    expect(subject).to validate_presence_of(:content)
  end
end