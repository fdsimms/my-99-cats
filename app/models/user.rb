class User < ActiveRecord::Base

  def self.find_by_credentials(credentials_hash)
    user = User.find_by_username(credentials_hash[:username])
    return nil unless user

    if user.is_password?(credentials_hash[:password])
      user
    else
      nil
    end
  end

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats

  def reset_session_token!
    self.session_token = SecureRandom.base64
    self.save!
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
