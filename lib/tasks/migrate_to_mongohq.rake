task :migrate_mongohq do
	require '/home/leonardo/work/controlehoras/app/models/lancamento.rb'
	
	MongoMapper.connection =  Mongo::Connection.from_uri('mongodb://kibiluzbad:inferno1@flame.mongohq.com:27067/controle_horas')
	MongoMapper.database = "controle_horas"

	SQLite3::Database.open('/home/leonardo/work/controlehoras/db/controleHoras_development.sqlite3').transaction { |db|
		db.results_as_hash = true	
		db.execute('select * from lancamentos'){ |row|
			l = Lancamento.new({:descricao => row["descricao"],:entrada => row["entrada"].gsub("T"," ").gsub("-07:00"," UTC"),:saida => row["saida"].gsub("T"," ").gsub("-07:00"," UTC"),:horas => row["horas"],:horas_extras => row["horas_extras"],:data => row["data"],:total => row["total"],:almoco => row["almoco"],:almoco_saida => !row["almoco_saida"].nil? ? row["almoco_saida"].gsub("T"," ").gsub("-07:00"," UTC") : nil,:almoco_volta => !row["almoco_volta"].nil? ? row["almoco_volta"].gsub("T"," ").gsub("-07:00"," UTC") : nil, :pago => row["pago"]})
			puts 'Migrando...'
			puts l.descricao
			puts l.entrada
			puts l.saida
			puts l.horas
			puts l.data
			puts l.total
			puts l.almoco
			l.save!
			puts 'Migrado...'
		}
	}
end
