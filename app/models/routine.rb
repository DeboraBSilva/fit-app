class Routine < ApplicationRecord
  has_many :exercise_routines
  has_many :exercises, through: :exercise_routines

  validates :name, presence: true
end
