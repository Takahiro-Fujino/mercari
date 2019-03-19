class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable
  has_many :products
  has_many :orders
  has_one :address, dependent: :destroy
  has_one :credit, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :post

  validates :nickname, presence: true

  validates :last_name, format: { with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "名 に数字や特殊文字は使用できません"}, presence: true, unless: :uid?
  validates :first_name, format: { with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "姓 に数字や特殊文字は使用できません"}, presence: true, unless: :uid?
  validates :last_name_kana, format: { with:/\A[ァ-ンー－]+\Z/, message: "名カナ を入力してください"}, presence: true, unless: :uid?
  validates :first_name_kana,format: { with:/\A[ァ-ンー－]+\Z/, message: "姓カナ を入力してください"}, presence: true, unless: :uid?
  validates :date_of_birth, presence: true, unless: :uid?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  #フォローのみを考える
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  #フォローしているユーザーを特定
  has_many :followings, through: :following_relationships
  #フォローされることを考える
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  #フォローされているユーザーを特定
  has_many :followers, through: :follower_relationships

  #現在のユーザーがフォーローしているかどうか
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  #フォローをする
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  #フォローを外す
  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

   def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        nickname: User.dummy_nickname(auth),
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end

  private

  def self.dummy_email(auth)
    if auth.provider == "facebook"#facebook時の処理
    "#{auth.uid}-#{auth.provider}@example.com"
    else
    "#{auth.info.email}"
    end
  end

  def self.dummy_nickname(auth)
    "#{auth.info.name}"
  end
end
