class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    # @todos = Todo.all
    @todos = Todo.order('completed ASC, LOWER(content)')
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.date_created = Time.new.strftime("%d %b %Y %H:%M")
    if @todo.content.blank?
      redirect_to new_todo_path, notice: "The content field cannot be blank"
    elsif @todo.save
       redirect_to todos_url, notice: 'Todo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Todo was successfully updated.'
    else
      render :edit 
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    if @todo.completed
      @todo.destroy
      redirect_to todos_url, notice: 'Todo has been cleared.'
    else
      @todo.destroy
      redirect_to todos_url, notice: 'Todo was successfully deleted.'
    end
  end

  # Mark as complete
  def completed
    @todo = Todo.find(params[:id])
    @todo.completed = true
    @todo.date_completed = Time.new.strftime("%d %b %Y %H:%M")
    if @todo.save
      redirect_to todos_url, notice: 'Todo has been marked as complete.'
    else
      render :new
    end
  end

  # Clear all completed
  def clear_all
    @clear = Todo.all
    @clear.each do |todo|
      if todo.completed
         todo.delete
      end      
    end
    redirect_to todos_url, notice: 'Completed todos have been cleared.'
  end

  # Delete all
  # def delete_all
  #   @delete_all = Todo.all
  #   @delete_all.each do |todo|
  #     todo.delete
  #   end
  #   redirect_to todos_url, notice: 'All todos have been deleted'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:content, :section, :date_created, :date_completed, :completed)
    end
end
