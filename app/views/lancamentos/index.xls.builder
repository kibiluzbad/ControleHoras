xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8" 
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet", 
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",    
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet" 
  }) do

  xml.Worksheet 'ss:Name' => 'Recent Orders' do
    xml.Table do
	  xml.Column 'ss:Width' => '57'
	  xml.Column 'ss:Index' => '5', 'ss:Width' => '158'
      # Header
      xml.Row do
          xml.Cell { xml.Data 'Data', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Entrada', 'ss:Type' => 'String' }
		  xml.Cell { xml.Data 'Almoço Saida', 'ss:Type' => 'String' }
		  xml.Cell { xml.Data 'Almoço Volta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saida', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Horas', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descricao', 'ss:Type' => 'String' }
      end

      # Rows
      for lancamento in @lancamentos
        xml.Row do
            xml.Cell { xml.Data lancamento.data.strftime('%d/%m/%Y'), 'ss:Type' => 'String' }
            xml.Cell { xml.Data lancamento.entrada.strftime('%H:%M'), 'ss:Type' => 'String' }
            xml.Cell { xml.Data lancamento.saida.strftime('%H:%M'), 'ss:Type' => 'String' }
			xml.Cell { xml.Data lancamento.almoco_saida.strftime('%H:%M'), 'ss:Type' => 'String' }
            xml.Cell { xml.Data lancamento.almoco_volta.strftime('%H:%M'), 'ss:Type' => 'String' }
            xml.Cell { xml.Data lancamento.total , 'ss:Type' => 'String' }
            xml.Cell { xml.Data lancamento.descricao , 'ss:Type' => 'String' }
        end
      end

    end
  end
end