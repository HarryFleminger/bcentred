class AddMinutesToReadToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :minutes_to_read, :integer, default: 5, null: false
  end
end
