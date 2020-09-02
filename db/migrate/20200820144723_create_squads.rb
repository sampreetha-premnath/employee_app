class CreateSquads < ActiveRecord::Migration
  def change
    create_table :squads do |t|
      t.string :squad_name
      t.timestamps
    end
  end
end
