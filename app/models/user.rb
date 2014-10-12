class User < ActiveRecord::Base
  devise :omniauthable
  has_many :memos, ->{order("created_at DESC")}
end
