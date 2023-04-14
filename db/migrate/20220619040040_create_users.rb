class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.string :google_uid, index: true
      t.string :apple_uid, index: true
      t.string :gender
      t.date :dob
      t.string :phone_code
      t.string :phone_number
      t.datetime :email_verified_at
      t.string :email_verification_token
      t.datetime :email_verification_sent_at
      t.string :name
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end
  end
end
