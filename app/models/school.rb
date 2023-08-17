class School < ApplicationRecord
  has_many :school_admins
  has_many :batches
  has_many :courses
  has_many :students

  validates_presence_of :name
end
