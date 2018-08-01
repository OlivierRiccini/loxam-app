class Message < ApplicationRecord
  after_create :send_contact_email

  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :content, length: { minimum: 10, maximum: 500 }

  private

  def send_contact_email
    MessageMailer.contact(self).deliver_now
  end
end
