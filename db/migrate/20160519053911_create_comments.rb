class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

    	t.references :user
    	t.references :photo
    	t.text :comment

      t.timestamps null: false
    end
    add_index :comments, :photo_id
  end
end
