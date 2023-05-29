class AddLikesToBLogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :likes, :integer, default: 0
  end
end
