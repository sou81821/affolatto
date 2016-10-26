class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :name, presence: true
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

  # パスワードなしでユーザ情報変更
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
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
