class User < ActiveRecord::Base
    # before_action :logged_in_user, only: [:edit, :update]

    # Dependent destroy allows all posts by a specific user
    # to be destroyed automatically if that user is deleted
    # by administrators.
    has_many :posts, dependent: :destroy

    has_many :comments

    has_secure_password

    validates :name,
        presence: true

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        format: { with: email_regex },
        uniqueness: { case_sensitive: false }

    validates :password,
        presence: true,
        length: { minimum: 6 },
        confirmation: true,
        allow_nil: true

    validates :password_confirmation,
        presence: true

    before_save :downcase_email

    attr_accessor :remember_token,
        :reset_token

    has_attached_file :avatar,
        styles: { medium: '300x300#', thumb: '100x100#', small: '50x50#' },
        default_url: 'avatar.png'

    validates_attachment_content_type :avatar,
        content_type: /\Aimage\/.*\Z/

    # Allows users to vote on posts
    acts_as_voter



    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def logged_in_user
        unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to '/'
        end
    end

    # Allow a user to be "remembered" even if they close the browser, with cookies.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # "Forgets" a user, if they choose to log out of a persistent session.
    def forget
        update_attribute(:remember_digest, nil)
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
      if remember_digest.nil?
        false
      else
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
      end
    end

   private

    def downcase_email
        self.email = email.downcase
    end


end
