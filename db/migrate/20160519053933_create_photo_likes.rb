class CreatePhotoLikes < ActiveRecord::Migration
  def change
    create_table :photo_likes do |t|

    	t.references :user
    	t.references :photo
    	
      t.timestamps null: false
    end
  end
end
