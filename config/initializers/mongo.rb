#MongoMapper.connection =  Mongo::Connection.from_uri('mongodb://kibiluzbad:inferno1@flame.mongohq.com:27067/controle_horas')
#MongoMapper.database = "controle_horas"

config = YAML.load_file(File.join(File.dirname(__FILE__),
   '../../config/database.yml'))

MongoMapper.connection = Mongo::Connection.new(config[Rails.env]["host"], config[Rails.env]["port"], { :logger => Rails.logger })
MongoMapper.database = config[Rails.env]["database"]
MongoMapper.database.authenticate(config[Rails.env]["user"], config[Rails.env]["password"])

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
