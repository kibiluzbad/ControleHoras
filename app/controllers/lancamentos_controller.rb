class LancamentosController < ApplicationController
  before_filter :load_date
  
  # GET /lancamentos
  # GET /lancamentos.xml
  def index
 
	 if(params[:date])
		@year = Integer(params[:date][:year])
		@month = Integer(params[:date][:month])
     end
	 if(!params[:month].nil? &&
		!params[:year].nil?)
		@year = Integer(params[:year])
		@month = Integer(params[:month])
     end
	 
     requested_date = Date.new(@year, @month, 1)
     from = requested_date
  	 to =  (requested_date >> 1) - 1
  	 
  	 @lancamentos = Lancamento.all(:order => 'data',:data => {'$gte' => Time.utc(from.year,from.month,from.day) , '$lte' => Time.utc(to.year,to.month,to.day)})
  	 
  	 if request.xhr?
  	 	render :layout => false
  	 else
  	 	respond_to do |format|
	      format.html # index.html.erb
	      format.xls  # exporta para xls
	      format.xml  { render :xml => @lancamentos }
  	 	end  	 
    end
  end

  # GET /lancamentos/1
  # GET /lancamentos/1.xml
  def show
    @lancamento = Lancamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lancamento }
    end
  end

  # GET /lancamentos/new
  # GET /lancamentos/new.xml
  def new
    @lancamento = Lancamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lancamento }
    end
  end

  # GET /lancamentos/1/edit
  def edit
    @lancamento = Lancamento.find(params[:id])
  end

  # POST /lancamentos
  # POST /lancamentos.xml
  def create
		#TODO: Refatorar carregamento de parametros da tela!
		saida_almoco = params[:lancamento][:almoco] ? "#{params[:lancamento]['almoco_saida(4i)']}:#{params[:lancamento]['almoco_saida(5i)']}" : nil
		volta_almoco = params[:lancamento][:almoco] ? "#{params[:lancamento]['almoco_volta(4i)']}:#{params[:lancamento]['almoco_volta(5i)']}" : nil


    @lancamento = Lancamento.new({:descricao=>params[:lancamento][:descricao],:data=>Date.new(params[:lancamento]["data(1i)"].to_i,params[:lancamento]["data(2i)"].to_i,params[:lancamento]["data(3i)"].to_i),:entrada=>"#{params[:lancamento]['entrada(4i)']}:#{params[:lancamento]['entrada(5i)']}",:saida=>"#{params[:lancamento]['saida(4i)']}:#{params[:lancamento]['saida(5i)']}",:almoco=>params[:lancamento][:almoco],:almoco_saida => saida_almoco, :almoco_volta => volta_almoco})

    respond_to do |format|
      if @lancamento.save
        flash[:notice] = 'Lancamento was successfully created.'
        format.html { redirect_to('/lancamentos/' + @year.to_s + '/' + @month.to_s) }
        format.xml  { render :xml => @lancamento, :status => :created, :location => @lancamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lancamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lancamentos/1
  # PUT /lancamentos/1.xml
  def update
    @lancamento = Lancamento.find(params[:id])
		#TODO: Refatorar carregamento de parametros da tela!
		saida_almoco = params[:lancamento][:almoco] ? "#{params[:lancamento]['almoco_saida(4i)']}:#{params[:lancamento]['almoco_saida(5i)']}" : nil
		volta_almoco = params[:lancamento][:almoco] ? "#{params[:lancamento]['almoco_volta(4i)']}:#{params[:lancamento]['almoco_volta(5i)']}" : nil

		if(params[:lancamento][:almoco])
		
		end
    respond_to do |format|
      if @lancamento.update_attributes({:descricao=>params[:lancamento][:descricao],:data=>Date.new(params[:lancamento]["data(1i)"].to_i,params[:lancamento]["data(2i)"].to_i,params[:lancamento]["data(3i)"].to_i),:entrada=>"#{params[:lancamento]['entrada(4i)']}:#{params[:lancamento]['entrada(5i)']}",:saida=>"#{params[:lancamento]['saida(4i)']}:#{params[:lancamento]['saida(5i)']}",:almoco=>params[:lancamento][:almoco],:almoco_saida => saida_almoco, :almoco_volta => volta_almoco})

        flash[:notice] = 'Lancamento was successfully updated.'
        format.html { redirect_to(@lancamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lancamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lancamentos/1
  # DELETE /lancamentos/1.xml
  def destroy
    @lancamento = Lancamento.find(params[:id])
    @lancamento.destroy

    respond_to do |format|
      format.html { redirect_to(lancamentos_url) }
      format.xml  { head :ok }
    end
  end

  def pagamento
	@year = Integer(params[:year])
	@month = Integer(params[:month])
	
	requested_date = Date.new(@year, @month, 1)
     from = requested_date
  	 to =  (requested_date >> 1) - 1
#TODO: Refatorar para efetuar uma atualização em batch.
	Lancamento.all(:order => 'data',:data => {'$gte' => Time.utc(from.year,from.month,from.day) , '$lte' => Time.utc(to.year,to.month,to.day)} ).each do |lancamento|
		lancamento.pago = true
		lancamento.save
	end
	
	flash[:notice] = "Pagamento do mes recebido."

	redirect_to "/lancamentos/#{@year}/#{@month}"
  end
  
  private
  def load_date
   hoje = Time.now
   
   @year = hoje.year
   @month = hoje.month
   
   if(!params[:year].nil? &&
	  !params[:month].nil?)
	  @year = params[:year].to_i
	  @month = params[:month].to_i
   end
  end
end

