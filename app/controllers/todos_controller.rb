class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    # Paginates current_users todos, 
    # Puts into alphabetical order by content, then by whether it is completed or not
    @todos = current_user.todos.paginate(:page => params[:page], :per_page => 10).order('completed ASC, LOWER(content)')
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    # Only shows todos if they belong to the current user.
    if @todo.user == !current_user
      redirect_to todos_url, notice: 'That task does not belong to you.'
    end
  end

  # GET /todos/new
  def new
    @todo = current_user.todos.build
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = current_user.todos.build(todo_params)
    @todo.date_created = Time.new.strftime("%d %b %Y %H:%M")
    if @todo.content.blank?
      redirect_to new_todo_path, notice: "The content field cannot be blank"
    elsif @todo.save
       redirect_to todos_url, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Task was successfully updated.'
    else
      render :edit 
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    # Destroy for completed todos are 'cleared'
    if @todo.completed
      @todo.destroy
      redirect_to todos_url, notice: 'Task has been cleared.'
    # Destroy for incomplete todos are 'deleted'
    else
      @todo.destroy
      redirect_to todos_url, notice: 'Task was successfully deleted.'
    end
  end

  # Mark as complete
  def completed
    @todo = Todo.find(params[:id])
    @todo.completed = true
    @todo.date_completed = Time.new.strftime("%d %b %Y %H:%M")
    if @todo.save
      redirect_to todos_url, notice: 'Task has been marked as complete.'
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
    redirect_to todos_url, notice: 'Completed tasks have been cleared.'
  end

  # Delete all
  # def delete_all
  #   @delete_all = Todo.all
  #   @delete_all.each do |todo|
  #     todo.delete
  #   end
  #   redirect_to todos_url, notice: 'All todos have been deleted'
  # end

  def report
    report = Array.new
    @todos.each do |todo|
      if todo.completed
        report << todo
        CSV.open('todos_report.csv', 'wb') do |csv|
          csv << report
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def correct_user
      @todo = current_user.todos.find_by(id: params[:id])
      redirect_to todos_path, notice: "You are not authorised to view this task as you are not its owner" if @todo.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:content, :section, :date_created, :date_completed, :completed)
    end
end
