class Room < ApplicationRecord
  belongs_to :hostel, class_name: 'Hostel'
  has_many :bookings, class_name: "Booking", dependent: :destroy
end
