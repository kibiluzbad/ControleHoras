class CreateLancamentos < ActiveRecord::Migration
  def self.up
    create_table :lancamentos do |t|
      t.time :entrada
      t.time :saida
      t.string :descricao
      t.decimal :horas
      t.decimal :horas_extras
      t.date :data

      t.timestamps
    end
  end

  def self.down
    drop_table :lancamentos
  end
end
