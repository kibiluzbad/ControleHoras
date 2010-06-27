// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
		$('#lancamento_horas').attr('readonly','true');
	    $('#lancamento_horas_extras').attr('readonly','true');
		display_almoco($('.com_almoco'));
		$('.com_almoco').click(function(){
			display_almoco($(this));
		});
		
		function display_almoco(elem){
			if($(elem).attr('checked')){
				$('#almoco').show();
			}else{
				$('#almoco').hide();
			}
		}
});
