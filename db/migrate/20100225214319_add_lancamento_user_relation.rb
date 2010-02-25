class AddLancamentoUserRelation < ActiveRecord::Migration
  def self.up
	change_table :lancamentos do |t|
		t.integer :user_id
	end

	user = User.first
	Lancamento.all.each do |l|
		l.user = user
		l.save!
	end
  end

  def self.down
	change_table :lancamentos do |t|
		t.remove :user_id
	end
  end
end
