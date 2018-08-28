class User < ApplicationRecord
  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  has_many :invoices, dependent: :destroy
  has_many :favorites
  has_many :products, :through => :favorites

  # validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  mount_uploader :avatar, AvatarUploader

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def subscribe_to_newsletter
    SubscribeToNewsletterService.new(self).call
  end

end
