class Lancamento < ActiveRecord::Base
	validates_presence_of :entrada, :saida, :data, :descricao
	
	before_save {|l| l.calcular_horas()}
    
    def calcular_horas()
    	hora_de_almoco = 0
    	
    	if almoco
    		hora_de_almoco = 1
    	end	
    	
    	self.total = ((self.saida - self.entrada) / 3600).round(2) - hora_de_almoco
    	self.horas = self.total
    	self.horas_extras = nil 
		
		if(self.horas > 8)
			self.horas_extras = self.horas - 8
			self.horas = 8
	    end
	end
end
