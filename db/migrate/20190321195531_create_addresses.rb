class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street, optional: false
      t.string :city, optional: false
      t.string :state, optional: false
      t.string :zip, optional: false

      t.timestamps
    end
  end
end
