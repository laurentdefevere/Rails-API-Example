class CreateToken < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :token_type
      t.datetime :expires_at
      t.string :refresh_token
      t.string :scope
      t.integer :expires_in
    end
  end
end
