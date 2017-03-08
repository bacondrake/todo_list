require 'spec_helper'
require 'todo'

def initialize
  @todo = Todo.new
end

describe Todo do
  it "has content" do
    expect(@todo.content).not_to be_empty
  end

  it "has a section" do
    expect(@todo.section).not_to be_empty
  end

  it "has a completed status" do
    expect(@todo.completed).not_to be_nil
  end

  it "is not complete" do
    expect(@todo.completed).to be_falsy
  end

  it "belongs to someone" do
    expect(@todo.user_id).not_to be_nil
  end

  it "belongs to a specific person" do
    expect(@todo.user_id).to eq(1)
  end

  # xit "has a pending test" do
  #   true
  # end

  # it "has another type of pending test" do
  #   pending
  #   expect(@todo).to exist
  # end
end