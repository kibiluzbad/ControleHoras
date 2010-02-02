class LancamentoAdicionaPago < ActiveRecord::Migration
  def self.up
	change_table :lancamentos do |t|
  		t.boolean :pago
  	end
  end

  def self.down
	remove_column :pago
  end
end
