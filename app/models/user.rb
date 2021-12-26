class User < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :sequentially_slugged

  has_secure_password

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
