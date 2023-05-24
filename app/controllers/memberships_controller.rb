class MembershipsController < ApplicationController
  before_action :find_gym, :find_client
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def create
    membership = Membership.new(params.permit(:charge))
    @gym.memberships << membership
    @client.memberships << membership
    membership.save!
    render json: membership, status: :created
  end

  private

  def find_gym
    @gym = Gym.find(params[:gym_id])
  rescue
    render json: { error: "Gym not found" }, status: :not_found
  end

  def find_client
    @client = Client.find(params[:client_id])
  rescue
    render json: { error: "Client not found" }, status: :not_found
  end

  def invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
