class AddMailSentToInvitation < ActiveRecord::Migration
  def self.up
    add_column :invitations, :mail_sent, :boolean, :default => false
    add_column :invitations, :follow_up_sent, :boolean, :default => false
  end

  def self.down
    remove_column :invitations, :mail_sent
    remove_column :invitations, :follow_up_sent
  end
end
