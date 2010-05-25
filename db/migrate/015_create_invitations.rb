class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :email
      t.integer :survey_id
      t.string :token
      t.boolean :response, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
