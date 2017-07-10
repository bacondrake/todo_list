require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { FactoryGirl.create(:todo) }
  let(:complete_todo) { FactoryGirl.create(:todo_complete) }

  it "has content" do
    expect(todo.content).to_not be_nil
  end

  it "has a section" do
    expect(todo.section).to_not be_nil
  end

  it "can be marked complete" do
    expect(complete_todo.completed).to be_truthy
  end
end
