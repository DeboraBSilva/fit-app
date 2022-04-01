# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject { described_class.new(description: 'Exercise 1', intensity: 0) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_inclusion_of(:intensity).in_range(0..10) }

  it { should have_many(:exercise_routines) }
  it { should have_many(:routines).through(:exercise_routines) }
end
