class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :answergroups, :type, :group
  end
end
