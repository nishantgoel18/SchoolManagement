class Student < User
  belongs_to :school
  has_many :enrollments, foreign_key: :user_id
  has_many :batches, -> {where('enrollments.status = ?', 'Accepted')}, through: :enrollments
  has_many :courses, through: :batches

  def classmates
    Student.joins(:batches, :courses).where(enrollments: {batch: self.batches}).where.not(enrollments: {user_id: self.id})
  end

end