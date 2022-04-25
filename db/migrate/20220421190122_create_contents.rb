class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :heading
      t.text :desc

      t.timestamps
    end
  end
end
