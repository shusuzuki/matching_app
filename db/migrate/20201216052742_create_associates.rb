class CreateAssociates < ActiveRecord::Migration[5.2]
  def change
    create_table :associates do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :associates, :follower_id
    add_index :associates, :followed_id
    add_index :associates, [:follower_id, :followed_id], unique: true
  end
end
