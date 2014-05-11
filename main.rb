require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

get '/' do
	@products = Item.all
	@random = []
	@random =@products.sample(10)
	erb :home
end

get '/about.erb' do
	erb :about 
end

get '/products.erb' do
	@products = Item.all
	erb :products
end

get '/buyform.erb/:id' do
	@product = Item.find(params[:id])
	erb :buyform
end

post '/thanks.erb/:id' do
	@product = Item.find(params[:id])
	alert = ""
	@qtypurchased = params[:qty]
	@price = @qtypurchased.to_i*@product.price.to_i
	if @qtypurchased.to_i > @product.quantity.to_i
		alert = "Not enough stock"
		
	else
		@payment = MoneyCalculator.new params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands]
		@received = @payment.totalpay
		@sukli = @payment.change(@price)
		
		if @price.to_i > @received.to_i
			alert = "Not enough money"
	
		else
			@give = @received.to_i - @price.to_i
			@product.update_attributes!(
			quantity: @product.quantity.to_i-@qtypurchased.to_i, sold: @product.sold.to_i+@qtypurchased.to_i
			)	
			erb :thanks
		end
	end
end
