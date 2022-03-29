require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'john@email.com', encrypted_password: 'password') }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:encrypted_password) }
  it { is_expected.to validate_uniqueness_of(:reset_password_token) }
end
