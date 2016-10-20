class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :tweets

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.get_email(auth),
        password: Devise.friendly_token[0, 20],
        name:     auth.info.name
      )
    end

    user
  end

  private
  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    return email
  end
end
