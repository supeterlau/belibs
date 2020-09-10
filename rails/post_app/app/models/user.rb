class User < ApplicationRecord
  has_many :microposts

  # name email 不为空
  validates :name, presence: true
  validates :email, presence: true
end
