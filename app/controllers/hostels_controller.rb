class HostelsController < ApplicationController
  include JsonWebTokenValidation

  before_action :validate_json_web_token
  before_action :admin?, except: :index

  def index
    render json: HostelSerializer.new(Hostel.all), status: :ok
  end

  def create
    begin
      hostel = Hostel.new(hostel_params)
      hostel.save!
      render json: HostelSerializer.new(hostel), status: :created
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }
    end
  end

  def destroy
    hostel = Hostel.find_by_id(params[:id])
    return render json: { message: "Hostel not present" }, status: :ok unless hostel.present?
    hostel.destroy
    render json: { message: "Hostel deleted successfully" }, status: :ok
  end

  def update
    hostel = Hostel.find_by_id(params[:id])
    return render json: { message: "Hostel not present" }, status: :ok unless hostel.present?
    hostel.update(hostel_params)
    render json: HostelSerializer.new(hostel), status: :ok
  end

  private

  def admin?
    return render json: { message: "You are not an admin" }, status: :unauthorized unless @user.admin?
  end

  def hostel_params
    params.require(:data).permit(:name, :address, :phone)
  end
end
