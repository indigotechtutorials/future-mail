class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :to_address
      t.string :subject
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
