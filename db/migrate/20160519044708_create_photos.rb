class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

    	t.references :user
    	t.references :place

    	t.string :title, default: ""
    	t.text   :description  #, default: ""   # mysql database cannot accept default values for text/blob types

      t.timestamps null: false
    end
    add_attachment :photos, :image
  end
end
