class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true, presence: true
  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}".strip
  end
end
