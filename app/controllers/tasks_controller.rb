class TasksController < ApplicationController
  before_action :find_goal, only: [:update]
  before_action :find_task, only: [:edit, :update, :completed, :incomplete]
  skip_before_action :verify_authenticity_token

  def new
    @task = Task.new
    @goal = Goal.find(params[:goal_id])
    @task.goal = @goal
    authorize @task
  end

  def completed
    authorize @task
    @task.update(completed: true)
    @info = "You completed: #{@task.name}"
    respond_to do |format|
      format.html { redirect_to goal_path(@task.goal) }
      format.text { render partial: "shared/info", locals: { info: @info }, formats: [:html] }
    end
  end

  def incomplete
    authorize @task
    @task.update(completed: false)
    @info = "Not done with: #{@task.name} yet"
    respond_to do |format|
      format.html { redirect_to goal_path(@task.goal) }
      format.text { render partial: "shared/keepon", locals: { keepon: @info }, formats: [:html] }
    end
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @task = Task.new(task_params)
    @task.goal = @goal
    authorize @task
    if @task.save
      redirect_to goal_path(@goal)
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:goal_id])
    authorize @task
    @task.destroy
    redirect_to goal_path(@task.goal_id), status: :see_other
  end

  private

  def find_goal
    @goal = Goal.find(params[:id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end
end
