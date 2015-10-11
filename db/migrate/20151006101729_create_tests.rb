class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|

      t.string :course
      t.string :professor
      t.string :year
      t.string :middle
      t.string :fileing
    
      t.timestamps null: false
    end
  end
end
