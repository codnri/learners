class AddCheckboxesToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :first_check, :boolean
    add_column :tasks, :second_check, :boolean
    add_column :tasks, :third_check, :boolean
  end
end
