class User < ActiveRecord::Base

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user

    if user.is_password?(password)
      user
    else
      nil
    end
  end

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  attr_reader :password

  def reset_session_token!
    self.session_token = SecureRandom.base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.base64
  end
end
