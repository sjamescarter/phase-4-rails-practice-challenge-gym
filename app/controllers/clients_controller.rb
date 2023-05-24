class ClientsController < ApplicationController
  before_action :find_client, only: [:show, :update]

  def index 
    render json: Client.all
  end

  def show
    client = {
        id: @client.id,
        name: @client.name,
        age: @client.age,
        total_dues: @client.total_dues
    }
    render json: client
  end

  def update
    @client.update!(params.permit(:name, :age))
    render json: @client, status: :accepted
  end

  private

  def find_client
    @client = Client.find(params[:id])
  rescue
    render json: { error: "Client not found" }, status: 404
  end

end
