require 'rails_helper'

RSpec.describe ExerciseRoutine, type: :model do
  it { should belong_to(:exercise).class_name('Exercise') }
  it { should belong_to(:routine).class_name('Routine') }
end
