class Lancamento
	include MongoMapper::Document
	
	key :entrada, Time
  key :saida, Time
  key :descricao, String
  key :horas, Float
  key :horas_extras, Float
  key :data, Date
	key :total, Float
	key :almoco, Boolean
	key :almoco_saida, Time
	key :almoco_volta, Time
	key :pago, Boolean

	validates_presence_of :entrada, :saida, :data, :descricao
	validate :valida_hora_do_almoco, :if => "almoco"
	#TODO: Habilitar relacionamento com usuários	
	#belongs_to :user
	
	before_save {|l| l.calcular_horas()}
	
	def horario_almoco()
		if almoco
			if self.almoco_volta.nil? ||
			   self.almoco_saida.nil?
				return 1
			end

    		return ((self.almoco_volta - self.almoco_saida) / 3600)
    	end
		return 0
	end
	
	def horario_almoco_minutos()
		valor = horario_almoco() * 3600
		Lancamento.to_human_hour(valor)
	end
    
    def calcular_horas()
    	hora_de_almoco = horario_almoco()
    	
    	self.total = ((self.saida - self.entrada) / 3600).round(2) - hora_de_almoco
    	self.horas = self.total
    	self.horas_extras = nil 
		
		if(self.horas > 8)
			self.horas_extras = self.horas - 8
			self.horas = 8
	    end
	end

	def total_human_hour()
		Lancamento.to_human_hour(self.total * 3600)
	end

	def extra_human_hour()
		Lancamento.to_human_hour(self.horas_extras * 3600) unless self.horas_extras.nil?
	end

	def self.human_hour(value)
		to_human_hour(value * 3600)
	end
	
	private
	def valida_hora_do_almoco()
		if !self.almoco_saida.nil? &&
			!self.almoco_volta.nil?				
			errors.add(:almoco, "invalido") if 
				self.almoco_saida >= self.almoco_volta ||
				self.almoco_saida < self.entrada ||
				self.almoco_saida > self.saida ||
				self.almoco_volta > self.saida
		end
	end

	def self.to_human_hour(value)
		[(value/3600).to_i, (value/60 % 60).to_i].map{|t| t.to_s.rjust(2, '0')}.join(':')
	end
end
