MongoMapper.connection =  Mongo::Connection.from_uri('mongodb://kibiluzbad:inferno1@flame.mongohq.com:27067/controle_horas')
MongoMapper.database = "controle_horas"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
