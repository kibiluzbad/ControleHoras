module ApplicationHelper
 def to_sim_nao
		self ? "Sim" : "Nao"
	end
end

class TrueClass
	include ApplicationHelper
end

class FalseClass
	include ApplicationHelper
end
