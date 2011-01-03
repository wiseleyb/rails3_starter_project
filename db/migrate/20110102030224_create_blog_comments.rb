class CreateBlogComments < ActiveRecord::Migration
  def self.up
    create_table :blog_comments do |t|
      t.integer :blog_entry_id
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :url
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_comments
  end
end
