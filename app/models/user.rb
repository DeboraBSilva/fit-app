# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :encrypted_password, presence: true
  validates :reset_password_token, uniqueness: true
end
