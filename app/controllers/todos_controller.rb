class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy, :completed]
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :completed]
  helper_method :sort_column, :sort_direction

  def index
    # sets current user todos with pagination and alphabetical ordering by content
    @todos = current_user.todos.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html
      format.csv { send_data @todos.to_csv }
    end
  end

  def show
    # Only shows todos if they belong to the current user.
    if @todo.user == !current_user
      redirect_to todos_url, notice: 'How did you get here? That task does not belong to you.'
    end
  end

  def new
    @todo = current_user.todos.build
  end

  def edit
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
       redirect_to todos_url, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url, notice: 'Task was successfully deleted.'
  end

  # Mark as complete
  def completed
    if !@todo.completed
      @todo.completed = true
      session[:return_to] ||= request.referer # if todo is not on page 1, updating will keep it on the same page (rather than redirecting back to page 1)
    elsif @todo.completed = true
      @todo.completed = false
      session[:return_to] ||= request.referer # if todo is not on page 1, updating will keep it on the same page (rather than redirecting back to page 1)
    end

    if @todo.save
      redirect_to session.delete(:return_to)
    else
      render :new
    end
  end

  # Clear all completed
  def clear_all
    current_user.todos.each do |todo|
      if todo.completed
         todo.delete
      end
    end
    redirect_to todos_url, notice: 'Completed tasks have been cleared.'
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def correct_user
      @todo = current_user.todos.find_by(id: params[:id])
      redirect_to todos_path, notice: "You are not authorised to view this task as you are not its owner" if @todo.nil?
    end

    def todo_params
      params.require(:todo).permit(:content, :section, :completed)
    end

    def sort_column
      Todo.column_names.include?(params[:sort]) ? params[:sort] : "LOWER(content)"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
