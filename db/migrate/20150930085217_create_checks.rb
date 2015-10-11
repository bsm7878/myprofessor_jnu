class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|

      t.string :user_email
      t.string :sex
      t.string :professor_id
      t.float :a
      t.float :b
      t.float :c
      t.float :d
      t.float :e
      t.float :f
      t.text :course
      t.text :comment
      
      t.timestamps null: false
    end
  end
end
