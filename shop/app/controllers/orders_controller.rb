class OrdersController < ApplicationController
  before_filter :require_login, :only => [:destroy]
  before_filter :authenticate, :only => [:destroy]
  before_filter :track_session

  # GET /orders
  # GET /orders.xml
  def index
    @user_id = session[:user_id]
    @orders = Order.all(:conditions => { :user_id => @user_id })
    @order_items = []
    @orders.each do |o|
      o.order_total_sum
      @items = OrderItem.all(:conditions => { :order_id => o.id })
      unless @items.nil? 
        @order_items.concat(@items) 
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    #@order_items = Order_Items.find_by(order_id: params[:id]) 
    @order_items = OrderItem.all(:conditions => { :order_id => @order.id }) 
    @order.order_total_sum   

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new
    @order.status = "muokattavana"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @order_items = OrderItem.all(:conditions => { :order_id => @order.id }) 
    @order.order_total_sum
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    @order.order_total_sum
    @order_items = OrderItem.all(:conditions => { :order_id => @order.id }) 

    respond_to do |format|
      if @order.update_attributes(params[:order])
        if(params[:submit] == 'VAHVISTA TILAUS')
          format.html { redirect_to(confirm_path(@order), :notice => 'Tilaus valmiina jätettäväksi.') }
          format.xml  { head :ok }
        else
          format.html { redirect_to(@order, :notice => 'Tietoja päivitetty.') }
          format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /orders
  # POST /orders.xml
  def confirm
    @order = Order.find(params[:id])
    @order_items = OrderItem.all(:conditions => { :order_id => @order.id }) 
    @order.status = "Tilaus jätetty"

    respond_to do |format|
#      if @order.save
        format.html { render :notice => 'Tilaus jätetty.' }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
#      end
    end
  end


  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
