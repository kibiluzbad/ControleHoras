class LancamentoAdicionaTotalHoras < ActiveRecord::Migration
  def self.up
  	change_table :lancamentos do |t|
  		t.decimal :total
  	end
  end

  def self.down
  	remove_column :total
  end
end
