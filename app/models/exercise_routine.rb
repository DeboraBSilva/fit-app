# frozen_string_literal: true

class ExerciseRoutine < ApplicationRecord
  belongs_to :exercise
  belongs_to :routine
end
