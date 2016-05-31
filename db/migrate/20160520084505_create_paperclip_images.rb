class CreatePaperclipImages < ActiveRecord::Migration
  def change
    create_table :paperclip_images do |t|

      t.timestamps null: false
    end
  end
end
