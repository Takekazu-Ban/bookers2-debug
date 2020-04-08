class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  ### フォロー機能アソシエーション ###
  # アソシエーション フォロー
  has_many :relationships
  # user.followingsと書くとフォローしてるuserを取得できるようにする。
  has_many :followings, through: :relationships, source: :follow
  # アソシエーション フォロワー
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # userテーブルからフォロワーを取得
  has_many :followers, through: :reverse_of_relationships, source: :user

  # 重複、自分をフォローしているかどうか確認
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum:50}
end
