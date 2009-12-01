class LancamentosController < ApplicationController
before_filter :signin_required
  # GET /lancamentos
  # GET /lancamentos.xml
  def index
	 
	 if(params[:date])
	 
	 year = Integer(params[:date][:year])
	 month = Integer(params[:date][:month])
    requested_date = Date.new(year, month, 1)
    from = requested_date - 1
  	 to =  requested_date >> 1
  	 
  	 @lancamentos = Lancamento.all(:order => 'data',:conditions => ['data BETWEEN ? AND ?',from, to] )
  	 
  	 else
  	 
  	 @lancamentos = Lancamento.all(:order => 'data')
  	 
    end
	
    respond_to do |format|
      format.html # index.html.erb
      format.xls  # exporta para xls
      format.xml  { render :xml => @lancamentos }      
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
    @lancamento = Lancamento.new(params[:lancamento])

    respond_to do |format|
      if @lancamento.save
        flash[:notice] = 'Lancamento was successfully created.'
        format.html { redirect_to(@lancamento) }
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

    respond_to do |format|
      if @lancamento.update_attributes(params[:lancamento])
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
end
