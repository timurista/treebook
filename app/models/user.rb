class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :profile_name
  # attr_accessible :title, :body

  #this validates our code, using presence
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
                           uniqueness: true,
                           format: {
    with: /\A[a-zA-Z\-\_]+\Z/,
    message: 'must be formatted correctly.'
  }

  has_many :statuses
  # returns array of all statuses user has made

  def full_name
  	first_name + " " + last_name
  end
  # method that returns full name to use with user.full_name
  def gravatar_url
    stripped_email = email.strip #removes spaces
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://gravatar.com/avatar/#{hash}"
  end
end
