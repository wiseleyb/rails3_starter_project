class BlogComment < ActiveRecord::Base
  belongs_to :blog_entry
  belongs_to :user
end
