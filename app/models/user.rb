class User < ActiveRecord::Base
    # before_action :logged_in_user, only: [:edit, :update]

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

    before_save   :downcase_email

    attr_accessor :remember_token, 
        :reset_token

    has_attached_file :avatar, 
        styles: { medium: '300x300#', thumb: '100x100#' },
        default_url: 'avatar.png'

    validates_attachment_content_type :avatar, 
        content_type: /\Aimage\/.*\Z/
                      


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

   private

    def downcase_email
        self.email = email.downcase
    end

    
end
    
                         
    

