class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :blog_entries, :dependent => :destroy
end
