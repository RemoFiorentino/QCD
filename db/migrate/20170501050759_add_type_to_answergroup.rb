class AddTypeToAnswergroup < ActiveRecord::Migration
  def change
    add_column :answergroups, :type, :boolean
  end
end
