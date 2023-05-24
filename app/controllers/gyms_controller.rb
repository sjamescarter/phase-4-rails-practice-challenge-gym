class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :update, :destroy]

  def index
    render json: Gym.all
  end
  
  def show
    render json: @gym
  end

  def update
    @gym.update!(params.permit(:name, :address))
    render json: @gym, status: :accepted
  end
  
  def destroy
    @gym.destroy
    head :no_content
  end

  private

  def find_gym
    @gym= Gym.find(params[:id])
  rescue
    render json: { error: "Gym not found" }, status: 404
  end


end
