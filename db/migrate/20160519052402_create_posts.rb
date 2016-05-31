class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

    	t.references :user
    	t.references :community
    	t.string :title
    	t.text :post

      t.timestamps null: false
    end
    add_index :posts, :community_id
    add_index :posts, :user_id
  end
end
