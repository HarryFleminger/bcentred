class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :position, null: false, default: ""
      t.string :bio, null: false, default: ""

      t.timestamps
    end
  end
end
