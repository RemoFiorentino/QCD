class CreateAsignaturas < ActiveRecord::Migration
  def change
    create_table :asignaturas do |t|
      t.references :user, index: true, foreign_key: true
      t.string :division
      t.string :dpto
      t.string :programa
      t.string :nombre
      t.integer :nrc
      t.string :semestre
      t.integer :creditos
      t.string :objetivo1
      t.string :objetivo2
      t.string :objetivo3
      t.string :objetivo4
      t.string :objetivo5
      t.string :objetivo6
      t.string :objetivo7
      t.string :objetivo8
      t.string :objetivo9
      t.string :objetivo10

      t.timestamps null: false
    end
  end
end
