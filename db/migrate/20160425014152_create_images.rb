class CreateImages < ActiveRecord::Migration
  
  def up
    create_table :images do |t|
      t.string "url", :limit => 200, :null => false
      t.integer "ownerid", :null => false
      t.timestamps
    end
  end

  def down
  	drop_table :images
  end

end
