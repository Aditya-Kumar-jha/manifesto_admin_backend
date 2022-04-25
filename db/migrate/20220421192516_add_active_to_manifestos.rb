class AddActiveToManifestos < ActiveRecord::Migration[6.0]
  def change
    add_column :manifestos, :active, :boolean, :default => true
  end
end
