require 'securerandom'
class User < ActiveRecord::Base
  has_secure_password
  before_create :set_auth_token
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :name, :on => :create
  has_many :boards
  has_many :messages


  def set_auth_token
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end


end