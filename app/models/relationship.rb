class Relationship < ApplicationRecord
	# 存在しないクラス参照を防ぐ
	belongs_to :follower, class_name: 'User'
	belongs_to :following, class_name: "User"

	validates :follower_id, presence: :true
	validates :following_id, presence: true
end
