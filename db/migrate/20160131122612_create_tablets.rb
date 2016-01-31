class CreateTablets < ActiveRecord::Migration
  def change
    create_table :tablets do |t|
      t.string :name
      t.string :token

      t.timestamps null: false
    end
  end
end
