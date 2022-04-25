class CreateManifestos < ActiveRecord::Migration[6.0]
  def change
    create_table :manifestos do |t|
      t.string :name

      t.timestamps
    end
  end
end
