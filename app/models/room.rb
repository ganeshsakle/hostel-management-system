class Room < ApplicationRecord
  belongs_to :hostel, class_name: 'Hostel'
end
