class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :track, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
