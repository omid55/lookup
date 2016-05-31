class CreatePlacesTags < ActiveRecord::Migration
  def change
    create_table :places_tags do |t|

      t.references :place
      t.references :tag
      
      t.timestamps null: false
    end
  end
end
