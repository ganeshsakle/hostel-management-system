class Hostel < ApplicationRecord
  has_many :rooms, class_name: "Room", dependent: :destroy
end
