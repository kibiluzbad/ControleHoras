class AddUserDetails < ActiveRecord::Migration
    def self.up
	change_table :users do |t|
  		t.string :nickname
  		t.string :email
  		t.string :fullname
  	end
  end

  def self.down
	remove_column :nickname, :email, :fullname
  end
end
