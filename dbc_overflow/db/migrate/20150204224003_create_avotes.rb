class CreateAvotes < ActiveRecord::Migration
  def change
    create_table :avotes do |t|
      t.integer :value, :integer, default: 0
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
