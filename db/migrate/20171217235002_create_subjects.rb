class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :description
      t.string :url
      t.boolean :shared

      t.timestamps
    end
  end
end
