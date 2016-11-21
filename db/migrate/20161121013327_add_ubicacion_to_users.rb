class AddUbicacionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ubicacion, :string
  end
end
