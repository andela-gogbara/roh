class TodoController < ApplicationController
  def index
    @completed_todos = Todo.where("status like ?", "%Completed%")
    @pending_todos = Todo.where("status like ?", "%Pending%")
  end

  def new
    @todo = Todo.new
  end

  def show
    @todo = Todo.find(params["id"])
    @items = @todo.items
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to "/"
    else
      render :new
    end
  end

  def edit
    @todo = Todo.find(params["id"])
  end

  def update
    @todo = Todo.find(params["id"])
    if @todo.update(todo_params)
      redirect_to "/todo/#{@todo.id}/show"
    else
      render :edit
    end
  end

  def destroy
    @todo = Todo.find(params["id"])
    @todo.destroy
    redirect_to "/todo/index"
  end

  private

  def todo_params
    {
      title: params["todo"]["title"],
      body: params["todo"]["body"],
      status: params["todo"]["status"],
    }
  end
end
