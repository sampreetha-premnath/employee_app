class AddSquadNameToSquads < ActiveRecord::Migration
  def change
    add_column :squads, :squad_name, :string
  end
end
