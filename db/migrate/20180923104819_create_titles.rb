class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.text :content

      t.timestamps
    end
  end
end
