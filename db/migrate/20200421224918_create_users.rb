class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.string :gender

      t.timestamps
    end
  end
end
