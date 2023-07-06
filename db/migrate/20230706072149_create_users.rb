class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthdate, null: false, index: true
      t.string :address, null: false
      t.string :timezone_name, null: false, index: true
      t.timestamps
    end
  end
end
