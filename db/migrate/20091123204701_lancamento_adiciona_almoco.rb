class LancamentoAdicionaAlmoco < ActiveRecord::Migration
  def self.up
  	change_table :lancamentos do |t|
  		t.boolean :almoco
  	end
  end

  def self.down
  	remove_column :almoco
  end
end
