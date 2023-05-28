class CreateFavourites < ActiveRecord::Migration[7.0]
  def change
    create_table :favourites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :blog_post, foreign_key: true, null: false

      t.timestamps
    end
  end
end
