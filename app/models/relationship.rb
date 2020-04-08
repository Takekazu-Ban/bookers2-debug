class Relationship < ApplicationRecord
	# アソシエーション
	belongs_to :user
	# 存在しないクラス参照を防ぐ
	belongs_to :follow, class_name: 'User'

	validates :user_id, presence: true
	validates :follow_id, presence: true
end
