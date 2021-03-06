class LancamentosController < ApplicationController
  before_filter :load_date
  if(ENV['RAILS_ENV'] == 'production')	
  	before_filter :signin_required
  else
    before_filter :set_user
  end
  
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
  	 
  	 @lancamentos = Lancamento.all(:order => 'data',:conditions => ['data BETWEEN ? AND ? AND User_id = ?',from, to,@current_user.id] )
  	 
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
        @lancamento = Lancamento.first(:conditions => ['id = ? and user_id = ?',params[:id],@current_user.id])

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
    @lancamento = Lancamento.first(:conditions => ['id = ? and user_id = ?',params[:id],@current_user.id])
  end

  # POST /lancamentos
  # POST /lancamentos.xml
  def create
    @lancamento = Lancamento.new(params[:lancamento])    
    @lancamento.user = @current_user
    
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
    @lancamento = Lancamento.first(:conditions => ['id = ? and user_id = ?',params[:id],@current_user.id])

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
    @lancamento = Lancamento.first(:conditions => ['id = ? and user_id = ?',params[:id],@current_user.id])
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
	
	Lancamento.all(:order => 'data',:conditions => ['data BETWEEN ? AND ? and user_id = ?',from, to,@current_user.id] ).each do |lancamento|
		lancamento.pago = true
		lancamento.save
	end
	
	flash[:notice] = "Pagamento do mes recebido."
	
	redirect_to :action => "index"
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
  
  def set_user
      @current_user = User.first
  end
end

