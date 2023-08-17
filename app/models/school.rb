class School < ApplicationRecord
  has_many :school_admins, dependent: :destroy
  has_many :batches, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :students, dependent: :destroy

  validates_presence_of :name
end
