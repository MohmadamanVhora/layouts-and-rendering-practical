class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password
      t.boolean :gender
      t.string :mobile_number
      t.date :birth_date
      t.string :document

      t.timestamps
    end
  end
end
