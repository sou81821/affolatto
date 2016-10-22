class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :tweets

  has_attached_file :avatar,
                    :styles => { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      r = open(auth.info.image, :allow_redirections=>:safe)
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.get_email(auth),
        password: Devise.friendly_token[0, 20],
        name:     auth.info.name,
        fb_avatar: auth.info.image
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

  def self.get_image(auth)
    r = open(auth.info.image, :allow_redirections=>:safe)
    image_data = r.read
    file_size = r.length
    file_type = "image/jpeg"
  end
end
