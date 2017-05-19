class CreateToken < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :token_type
      t.integer :expires_in
      t.string :refresh_token
      t.string :scope
    end
  end
end
