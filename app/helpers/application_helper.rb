# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def to_sim_nao
		self ? "Sim" : "Não"
	end
end

class TrueClass
	include ApplicationHelper
end

class FalseClass
	include ApplicationHelper
end
