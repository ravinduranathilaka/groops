class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.where.not(id: current_user.id)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new

    group_ids = current_user.group.bfs_descendant_ids
    @assignable_groups = Group.where(id: group_ids)
  end

  # GET /users/1/edit
  def edit

    group_ids = current_user.group.bfs_descendant_ids
    @assignable_groups = Group.where(id: group_ids)
  end

  def check_username
    username = params[:username].to_s.strip

    available =
      username.present? &&
      username.length >= 3 &&
      !User.exists?(username: username)
  
    render json: { available: available }
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.id == current_user.id
      redirect_to users_path, alert: "You cannot delete yourself."
    else
      @user.destroy
      redirect_to users_path, notice: "User deleted successfully."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :name, :group_id)
    end
end
