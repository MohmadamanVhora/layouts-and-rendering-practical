class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :gender
      t.string :mobile_number
      t.date :birth_date
      t.string :document
      t.string :hobbies

      t.timestamps
    end
  end
end
