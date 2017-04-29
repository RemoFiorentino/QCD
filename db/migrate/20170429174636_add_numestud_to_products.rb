class AddNumestudToProducts < ActiveRecord::Migration
  def change
    add_column :asignaturas, :num_estud, :integer
  end
end
