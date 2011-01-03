class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  def perma_link_text
    self.created_at.to_ymdhm
  end
  
end
