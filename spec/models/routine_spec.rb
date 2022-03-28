require 'rails_helper'

RSpec.describe Routine, type: :model do
  subject { described_class.new(name: 'Routine 1') }

  it { is_expected.to validate_presence_of(:name) }
end
