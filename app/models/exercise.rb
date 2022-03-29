class Exercise < ApplicationRecord
  has_many :exercise_routines
  has_many :routines, through: :exercise_routines

  validates :description, presence: true
  validates_inclusion_of :intensity, in: 0..10
end
