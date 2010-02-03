class Lancamento < ActiveRecord::Base
	validates_presence_of :entrada, :saida, :data, :descricao
	validate :valida_hora_do_almoco, :if => "almoco"
	
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
		valor = horario_almoco() * 100
		return valor * 60 / 100
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
		errors.add(:almoco, "inválido") if 
			self.almoco_saida >= self.almoco_volta ||
			self.almoco_saida < self.entrada ||
			self.almoco_saida > self.saida ||
			self.almoco_volta > self.saida
	end
end
