class CreateQcds < ActiveRecord::Migration
  def change
    create_table :qcds do |t|
      t.references :asignatura, index: true, foreign_key: true
      t.string :salon
      t.datetime :fecha
      t.boolean :grupo

      t.timestamps null: false
    end
  end
end
