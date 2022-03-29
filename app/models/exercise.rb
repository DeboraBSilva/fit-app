class Exercise < ApplicationRecord
  has_and_belongs_to_many :routines

  validates :description, presence: true
  validates_inclusion_of :intensity, in: 0..10
end
