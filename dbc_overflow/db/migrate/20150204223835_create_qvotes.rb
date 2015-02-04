class CreateQvotes < ActiveRecord::Migration
  def change
    create_table :qvotes do |t|
      t.integer :value, :integer, default: 0
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
