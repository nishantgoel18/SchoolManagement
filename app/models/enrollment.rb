class Enrollment < ApplicationRecord
  belongs_to :student, foreign_key: :user_id
  belongs_to :batch

  validates :user_id, uniqueness: {scope: :batch_id, message: 'has already been registered for the batch'}
  validates :status, inclusion: {in: ['Accepted', 'Pending', 'Denied']}
end
