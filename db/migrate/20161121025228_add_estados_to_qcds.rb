class AddEstadosToQcds < ActiveRecord::Migration
  def change
    add_column :qcds, :estados, :integer
  end
end
