class BookingSerializer
  include JSONAPI::Serializer
  attributes :id, :room_id, :user_id, :check_in_date, :status, :created_at
end
