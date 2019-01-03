class User < ActiveRecord::Base
  has_many :user_queens
  has_many :queens, through: :user_queens
end
