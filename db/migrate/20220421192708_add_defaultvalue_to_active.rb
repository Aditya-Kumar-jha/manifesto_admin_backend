class AddDefaultvalueToActive < ActiveRecord::Migration[6.0]
  def change
    def up
      change_column :contents, :active, :boolean, default: true
      change_column :manifestos, :active, :boolean, default: true
    end
    
    def down
      change_column :contents, :active, :boolean, default: nil
      change_column :manifestos, :active, :boolean, default: nil
    end
  end
end
