class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

    	t.references :user
    	t.references :place
    	t.string :title
    	t.text :description

      t.timestamps null: false
    end
     add_index :reviews, :place_id
     add_index :reviews, :user_id
  end
end
