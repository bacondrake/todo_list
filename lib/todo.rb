class Todo
  attr_accessor :content, :section, :completed, :user_id

  def initialize
    @content = "content"
    @section = "section"
    @completed = false;
    @user_id = 1
  end

  @todo = Todo.new
end