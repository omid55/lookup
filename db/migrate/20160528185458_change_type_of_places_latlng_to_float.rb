class ChangeTypeOfPlacesLatlngToFloat < ActiveRecord::Migration
  def up
  	change_column :places, :lat, :float
  	change_column :places, :lng, :float
  end

  def down
  	change_column :places, :lat, :decimal
  	change_column :places, :lng, :decimal
  end
end
