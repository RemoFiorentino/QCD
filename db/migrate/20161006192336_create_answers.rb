class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :qcd, index: true, foreign_key: true
      t.integer :order
      t.string :answer

      t.timestamps null: false
    end
  end
end
