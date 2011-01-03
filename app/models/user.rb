class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :login, :email, :password, :password_confirmation, :remember_me, :avatar
  
  has_attached_file :avatar, 
      :styles => { :t128 => "128x128>", :t96 => "96x96>", :t64 => "64x64>", :t48 => "48x48>", :t32 => "32x32>", :t16 => "16x16>" },
      :default_url => '/images/avatars/mushroom-spring-:style.png', 
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => "/avatars/:style/:id/:filename"

  has_many :forums, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_one  :blog, :dependent => :destroy
  has_many :blog_entries, :dependent => :destroy
  has_many :blog_comments, :dependent => :destroy
  
end
