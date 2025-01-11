class BookingsController < ApplicationController
  include JsonWebTokenValidation

  before_action :validate_json_web_token
  before_action :admin?, except: [:index, :create]

  def index
    if @user.admin?
      render json: BookingSerializer.new(Booking.all), status: :ok
    else
      render json: BookingSerializer.new(@user.bookings), status: :ok
    end
  end

  def create
    begin
      byebug
      booking = Booking.new(booking_params.merge(user_id: @user.id, room_id: params[:room_id]))
      booking.save!
      render json: BookingSerializer.new(booking), status: :created
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }
    end
  end

  def approve
    booking = Booking.find_by_id(params[:id])
    return render json: { message: "Booking not present" }, status: :ok unless booking.present?
    Booking.update(status: "approve")
    render json: { message: "Booking approved successfully" }, status: :ok
  end

  def reject
    booking = Booking.find_by_id(params[:id])
    return render json: { message: "Booking not present" }, status: :ok unless booking.present?
    Booking.update(status: "dis_approve")
    render json: { message: "Booking rejected successfully" }, status: :ok
  end

  private

  def admin?
    return render json: { message: "You are not an admin" }, status: :unauthorized unless @user.admin?
  end

  def booking_params
    params.require(:data).permit(:check_in_date)
  end
end


