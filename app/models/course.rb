class Course < ApplicationRecord
  belongs_to :school
  has_many :batches

  validates_presence_of :name
end
