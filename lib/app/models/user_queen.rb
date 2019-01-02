class UserQueen < ActiveRecord::Base
   belongs_to :user
   belongs_to :queens
end
