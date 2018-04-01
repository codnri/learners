class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.string :description
      t.boolean :done
      t.datetime :registration_date
      t.datetime :first_reminder_date
      t.datetime :second_reminder_date
      t.datetime :third_reminder_date

      t.timestamps
    end
  end
end
