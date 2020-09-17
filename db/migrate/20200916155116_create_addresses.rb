class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :city
      t.integer :pincode
    end
  end
end
