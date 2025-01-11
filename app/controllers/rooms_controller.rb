class RoomsController < ApplicationController
  include JsonWebTokenValidation

  before_action :validate_json_web_token
  before_action :admin?, except: :index

  def index
    hostel = Hostel.find_by_id(params[:id])
    render json: RoomSerializer.new(hostel.rooms), status: :ok
  end

  def create
    begin
      room = Room.new(room_params)
      room.save!
      render json: HostelSerializer.new(room), status: :created
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
    hostel.update(room_params)
    render json: HostelSerializer.new(hostel), status: :ok
  end

  private

  def admin?
    return render json: { message: "You are not an admin" }, status: :unauthorized unless @user.admin?
  end

  def room_params
    params.require(:data).permit(:room_description)
  end
end

