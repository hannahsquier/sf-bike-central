class User < ApplicationRecord
	has_many :incidents

	has_secure_password

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
