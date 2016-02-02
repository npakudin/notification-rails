class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :uuid
      t.json :payload
      t.json :gcm_response
      t.integer :gcm_response_code
      t.integer :accept_status
      t.references :tablet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
