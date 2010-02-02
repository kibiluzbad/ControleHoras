class LancamentoAdicionaHoraAlmoco < ActiveRecord::Migration
  def self.up
    change_table :lancamentos do |t|
  		t.time :almoco_saida
		t.time :almoco_volta
  	end
  end

  def self.down
	remove_column :almoco_saida, :almoco_volta
  end
end
