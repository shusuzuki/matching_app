class User < ApplicationRecord
  before_save { self.email = email.downcase }
  enum sex: { man: 0, woman: 1 }
  # validates_acceptance_of :qualification, allow_nil: false
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX, allow_blank: true },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6, allow_blank: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
end
