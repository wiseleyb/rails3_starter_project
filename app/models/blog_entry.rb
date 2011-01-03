class BlogEntry < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :blog_comments, :dependent => :destroy
end
