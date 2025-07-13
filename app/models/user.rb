class User < ApplicationRecord
  belongs_to :group
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, on: :create
end