class AddActiveToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :active, :boolean, :default => true
  end
end
