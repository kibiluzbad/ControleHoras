class Lancamento < ActiveRecord::Base
	validates_presence_of :entrada, :saida, :data, :descricao
	validate :valida_hora_do_almoco, :if => "almoco"
	belongs_to :user
	
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
		return to_human_hour(valor)
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

	def to_human_hour(value)
		return [(value/3600).to_i, (value/60 % 60).to_i].map{|t| t.to_s.rjust(2, '0')}.join(':')
	end
end
