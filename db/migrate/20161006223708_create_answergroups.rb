class CreateAnswergroups < ActiveRecord::Migration
  def change
    create_table :answergroups do |t|
      t.references :qcd, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
