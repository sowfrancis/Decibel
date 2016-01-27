class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :comment, index: true
      t.references :message, index: true
      t.string :content
      t.boolean  "check", default: false

      t.timestamps null: false
    end
  end
end
