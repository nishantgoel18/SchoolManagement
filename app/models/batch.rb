class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :school

  has_many :enrollments
  has_many :students, -> {where('enrollments.status = ?', 'Accepted')}, through: :enrollments

  validates_presence_of :name

end
