class OrderItemsController < ApplicationController
  before_filter :track_session

  # GET /order_items
  # GET /order_items.xml
  def index
    @order_items = OrderItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @order_items }
    end
  end

  # GET /order_items/1
  # GET /order_items/1.xml
  def show
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

  # GET /order_items/new
  # GET /order_items/new.xml
  def new
    @order_item = OrderItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order_item }
    end
  end

  # GET /order_items/1/edit
  def edit
    @order_item = OrderItem.find(params[:id])
  end

  # POST /order_items
  # POST /order_items.xml
  def create
    @order_id = session[:order_id]
    @order
    if @order_id
      @order = Order.find_by_id(@order_id)
    end
    if(@order.nil? or @order.status=='Tilaus jätetty') 
      @order = Order.new
      @order.skip_validations = true
      @order.status = "muokattavana"
      @order.save
      session[:order_id] = @order.id
    end
    @order_item = OrderItem.new(params[:order_item])
    @item = Item.find(@order_item.item_id)
    @order_item.item_salesprice = @item.current_salesprice

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to(@order_item, :notice => 'OrderItem was successfully created.') }
        format.xml  { render :xml => @order_item, :status => :created, :location => @order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /order_items
  # POST /order_items.xml
  def addtocart 
    @order_id = session[:order_id]
    @order
    if @order_id
      @order = Order.find_by_id(@order_id)
    end
    if(@order.nil? or !@order.status or @order.status!='muokattavana') 
      @order = Order.new
      @order.skip_validations = true
      @order.user_id = session[:user_id]
      @order.status = "muokattavana"
      @order.save
      session[:order_id] = @order.id
    end

    @order_item = OrderItem.new
    @order_item.order_id = @order.id
    @order_item.item_id = params[:item][:id]
    @order_item.amount = params[:item][:saldo]
    @item = Item.find(@order_item.item_id)
    @order_item.item_salesprice = @item.current_salesprice

    respond_to do |format|
    @item.saldo -= @order_item.amount
      if @order_item.save
        @item.save
        format.html { redirect_to(orders_path, :notice => 'Tuote lisätty tilaukseen.') }
        format.xml  { render :xml => @order_item, :status => :created, :location => @order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /order_items/1
  # PUT /order_items/1.xml
  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to(@order_item, :notice => 'OrderItem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.xml
  def destroy
    @order_item = OrderItem.find(params[:id])
    @item = Item.find(@order_item.item_id)
    @item.saldo += @order_item.amount
    @order_item.destroy
    @item.save

    respond_to do |format|
      #format.html { redirect_to(order_items_url) }
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

end
