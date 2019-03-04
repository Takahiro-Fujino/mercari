class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  # validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :date_of_birth, presence: true

  validates :last_name, format: { with:/\A[ぁ-んァ-ン一-龥]\Z/, message: "名 に数字や特殊文字は使用できません"}, presence: true, unless: :uid?
  validates :first_name, format: { with:/\A[ぁ-んァ-ン一-龥]\Z/, message: "姓 に数字や特殊文字は使用できません"}, presence: true, unless: :uid?
  validates :last_name_kana, format: { with:/\A[ァ-ンー－]+\Z/, message: "名カナ を入力してください"}, presence: true, unless: :uid?
  validates :first_name_kana,format: { with:/\A[ァ-ンー－]+\Z/, message: "姓カナ を入力してください"}, presence: true, unless: :uid?
  validates :date_of_birth,format: { with:/\A\d{8}\z/, message: "生年月日8桁を数字で入力してください"},numericality: { greater_than: 19000000, message:"何歳ですか？笑" }, presence: true, unless: :uid?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }


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