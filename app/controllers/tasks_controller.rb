class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    # Find all groups accessible from the current user’s group
    group_ids = current_user.group.bfs_descendant_ids
  
    # Fetch tasks where visible_up_to_id matches those groups
    @tasks = Task.where(visible_up_to_id: group_ids)
    # Search tasks
    if params[:query].present?
      @tasks = @tasks.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @tasks = @tasks
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
      # Get current group and descendants
    group_ids = current_user.group.bfs_descendant_ids

    # Include user's own group if it's not already in bfs_descendant_ids
    group_ids << current_user.group_id unless group_ids.include?(current_user.group_id)

    # Load filtered groups and users
    @available_groups = Group.where(id: group_ids).order(:name)
    @available_users = User.where(group_id: group_ids).order(:name)
  end

  # GET /tasks/1/edit
  def edit
    # Get current group and descendants
    group_ids = current_user.group.bfs_descendant_ids
  
    # Include user's own group if it's not already in bfs_descendant_ids
    group_ids << current_user.group_id unless group_ids.include?(current_user.group_id)
  
    # Load filtered groups and users
    @available_groups = Group.where(id: group_ids).order(:name)
    @available_users = User.where(group_id: group_ids).order(:name)
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.created_by = current_user

    if @task.assigned_to_id.present?
      @task.status = "assigned"
      @task.assigned_on = Time.current
    else
      @task.status = "unassigned"
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update

    if @task.update(task_params)
      # Handle status changes
      if @task.status == "completed" && @task.completed_on.blank?
        @task.update(completed_on: Time.current)
      elsif @task.status != "completed" && @task.completed_on.present?
        @task.update(completed_on: nil)
      end
  
      # Handle assignment changes
      if @task.assigned_to_id.present? && @task.status == "unassigned"
        @task.update(status: "assigned", assigned_on: Time.current)
      elsif @task.assigned_to_id.blank? && @task.status == "assigned"
        @task.update(status: "unassigned", assigned_on: nil)
      end
    end

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

    # Get current group and descendants
    group_ids = current_user.group.bfs_descendant_ids

    # Include user's own group if it's not already in bfs_descendant_ids
    group_ids << current_user.group_id unless group_ids.include?(current_user.group_id)
      
    # Load filtered groups and users
    @available_groups = Group.where(id: group_ids).order(:name)
    @available_users = User.where(group_id: group_ids).order(:name)
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :name, :description, :created_by_id, :assigned_to_id, :visible_up_to_id, :urgency, :status, :assigned_on, :completed_on ])
    end
end
