class Booking < ApplicationRecord
  belongs_to :room, class_name: 'Room'
  belongs_to :user, class_name: 'User'

  enum status: { pending: 'pending', approve: 'approve', dis_approve: 'dis_approve' }
end
