class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|

      t.string :img
      t.string :name
      t.string :space
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
