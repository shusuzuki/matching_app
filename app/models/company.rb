class Company < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :company_name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX, allow_blank: true },
                    uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, length: { minimum: 6, allow_blank: true }
  validates :profile, length: { maximum: 50 }
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
end
