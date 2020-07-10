require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { FactoryBot.build(:todo) }
  let(:complete_todo) { FactoryBot.build(:todo_complete) }

  it "has content" do
    expect(todo.content).to_not be_nil
  end

  it "has a section" do
    expect(todo.section).to_not be_nil
  end

  it "can be marked complete" do
    expect(complete_todo.completed).to be_truthy
  end

  it "does not save a new todo without content" do
    # Try to save contentless todo
  end

  it "does not save a new todo without a section" do
    # Try to save sectionless todo
  end
end
