# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Routine, type: :model do
  subject { described_class.new(name: 'Routine 1') }

  it { is_expected.to validate_presence_of(:name) }

  it { should have_many(:exercise_routines) }
  it { should have_many(:exercises).through(:exercise_routines) }
end
