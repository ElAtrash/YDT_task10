class Api::V1::TeamsController < ApplicationController
  before_action :find_team, only: [:show, :update, :destroy]

  def index
    @teams = Team.where(nil)
    filtering_params(params).each do |key, value|
      @teams = @teams.public_send("filter_by_#{key}", value) if value.present?
    end
    render json: @teams
  end

  def show
    render json: @team
  end

  def new
    @tean = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      render json: @team
    else
      render error: { error: 'Unable to create Team.' }, status: 400
    end
  end

  def update
    if @team
      @team.update(team_params)
      render json: { message: 'Team successfully updated.' }, status: 200
    else
      render json: { error: 'Unable to updte Team.' }, status: 400
    end
  end

  def destroy
    if @team
      @team.destroy
      render json: {message: 'Team was successfully deleted.'}, status: 200
    else
      render json: { error: 'Unable to delete Team.'}, status: 400
    end
  end

  private

  def find_team
    @team = Team.find(params[:id])
  end

  def filtering_params(params)
    params.slice(:name, :region)
  end

  def team_params
    params.require(:team).permit(:name, :region)
  end
end
