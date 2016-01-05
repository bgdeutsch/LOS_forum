class Post < ActiveRecord::Base
  belongs_to :user

  has_many :comments

  # Ensures a post cannot be created without content.
  validates :content,
      presence: true

  # Ensures a post cannot be created without a title.
  validates :title,
      presence: true,
      length: { maximum: 60 }

  # Posts will be automatically ordered from top down,
  # starting with the most recently created.
  # The -> notation indicates a 'proc', or anonymous function.
  # This is also known as a 'stabby lambda'.
  default_scope -> { order(created_at: :desc) }
end
