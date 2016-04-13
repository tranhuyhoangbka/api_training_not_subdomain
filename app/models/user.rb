class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  before_create :generate_authenticate_token!

  def generate_authenticate_token!
    begin
      self.auth_token = Devise.friendly_token
    end while(self.class.exists?(auth_token))
  end
end
