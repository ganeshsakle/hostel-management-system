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
      room = Room.new(room_params.merge(hostel_id: params[:hostel_id]))
      room.save!
      render json: RoomSerializer.new(room), status: :created
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }
    end
  end

  def destroy
    room = Room.find_by_id(params[:id])
    return render json: { message: "Room not present" }, status: :ok unless room.present?
    room.destroy
    render json: { message: "Room deleted successfully" }, status: :ok
  end

  def update
    room = Room.find_by_id(params[:id])
    return render json: { message: "Room not present" }, status: :ok unless room.present?
    room.update(room_params)
    render json: RoomSerializer.new(room), status: :ok
  end

  private

  def admin?
    return render json: { message: "You are not an admin" }, status: :unauthorized unless @user.admin?
  end

  def room_params
    params.require(:data).permit(:room_description)
  end
end

