class User < ApplicationRecord
	has_many :incidents

	has_secure_password

	# validates :username, presence: true, length: { in: 3..20 }, uniqueness: true
	# validates :password, presence: true, length: { in: 6..20 }
	
	def generate_auth_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_auth_token
    save
  end
end
