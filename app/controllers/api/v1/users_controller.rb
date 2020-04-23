class Api::V1::UsersController < ApplicationController
  before_action :set_team, except: [:home]
  before_action :set_team_user, only: [:show, :update, :destroy]

  def index
    render json: @team.users
  end

  def home
    @users = User.where(nil)
    @users = @users.filter_by_team(params[:team_id]) if params[:team_id].present?
    render json: @users
  end

  def show
    render json: @user
  end

  def new
    @user = @team.users.build
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: { error: 'Unable to create User.' }, status: 400
    end
  end

  def update
    if @user
      @user.update(user_params)
      render json: { message: 'User successfully updated.' }, status: 200
    else
      reder json: { error: 'Unable to updte User.' }, status: 400
    end
  end

  def destroy
    if @user
      @user.destroy
      reder json: {message: 'User was successfully deleted.'}, status: 200
    else
      reder json: { error: 'Unable to delete User.'}, status: 400
    end
  end

  private

  def set_team_user
    @user = @team.users.find_by!(id: params[:id]) if @team
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def user_params
    params.require(:user).permit(:team_id, :name, :phone, :gender)
  end
end
