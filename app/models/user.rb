class User < ActiveRecord::Base
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }

  def self.authenticate_with_credentials email, password
    format_email = email.downcase.strip
    if user = User.find_by(email: format_email).try(:authenticate, password)
      user
    else
      nil
    end
  end
end
