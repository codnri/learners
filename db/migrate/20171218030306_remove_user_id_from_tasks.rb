class RemoveUserIdFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :user_id
  end
end
