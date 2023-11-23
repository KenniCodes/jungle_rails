class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true

  before_validation :downcase_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.downcase.strip) if email.present?
    user if user&.authenticate(password)
  end

  private

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end