class User < ActiveRecord::Base
  attr_reader :password
  #before_validation :ensure_session_token

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, :allow_nil => true }
  validates :password_digest, presence: true

  has_many :posts, inverse_of: :user
  has_many :votes, inverse_of: :user
  has_many :comments, inverse_of: :user


  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def get_facebook_id(fb_username)
    self.fb_id = JSON[open("http://graph.facebook.com/#{fb_username}").read]
    self.save
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
