class TasksController < ApplicationController
  before_action :set_task, only: [ :update, :destroy ]

  def index
    @tasks = Task.all.order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "task", locals: { task: @task }) }
      format.html { redirect_to tasks_path }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "Task was successfully deleted." }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end
