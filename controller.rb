require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')


require_relative('./models/spendings')
require_relative('./models/users')
require_relative('./models/merchants')
require_relative('./models/tags')
also_reload ( './models/*')

#INDEX ROUTE
get '/counting_pennies' do
  @spendings = Spending.all()
  #All user id's the same, get first ID
  @user_id = Spending.all[1].user_id
  erb(:all_spendings)
end

#Home Page
get '/counting_pennies/home_page' do
  erb(:home_page)
end


#SEARCH Function
get '/counting_pennies/search' do
  erb(:search)
end

get '/counting_pennies/today' do
  @spendings = Spending.all()
  @user_id = Spending.all[1].user_id
  erb(:today)
end

#SEARCH INDEX
get '/counting_pennies/search_result/:search_item' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  @spendings = Spending.all()
  @result_spending = Spending.search(params['search_item'])
  @result_tag = Tag.search_tags(params['search_item'])
  @result_merchant = Merchant.search_merchants(params['search_item'])
  erb(:search_result)
end

#CREATE SEARCH
post '/counting_pennies/search_result' do
  @search_result = params['search']
  redirect to ("/counting_pennies/search_result/#{@search_result}")
end





#GET NEW TAG
get '/counting_pennies/tag/new' do
  erb(:new_tag)
end

#GET NEW TAG
get '/counting_pennies/merchant/new' do
  erb(:new_merchant)
end

# MERCHANT INDEX
get '/counting_pennies/merchant' do
  @merchants = Merchant.all()
  @number = 0
  erb(:merchant)
end

#CREATE NEW MERCHANT
post '/counting_pennies/merchant' do
  @merchant = Merchant.new( params )
  @merchant.save()
  redirect to ("/counting_pennies/confirm_merchant/#{@merchant.id}")
end


get '/counting_pennies/confirm_merchant/:id' do
  @merchant = Merchant.find(params['id'])
  erb(:merchant_confirm)
end




# TAG INDEX
get '/counting_pennies/tag' do
  @tags = Tag.all()
  @number = 0
  erb(:tag)
end


#CREATE NEW TAG
post '/counting_pennies/tag' do
  @tag = Tag.new( params )
  @tag.save()
  redirect to ("/counting_pennies/confirm/#{@tag.id}")
end

get '/counting_pennies/confirm/:id' do
  @tag = Tag.find(params['id'])
  erb(:tag_confirm)
end


#EDIT
get '/counting_pennies/:id/edit' do
  @spending = Spending.find(params[:id])
  @tag = Tag.all()
  @merchant = Merchant.all()
  erb( :edit )
end

#DELETE
post '/counting_pennies/:id/delete' do
  order = Spending.find( params[:id])
  order.delete()
  redirect to '/counting_pennies'
end


#GET NEW Expendature
get '/counting_pennies/new/:id' do
  @user = User.find (params[:id])
  @merchant = Merchant.all()
  @tag = Tag.all()
  erb(:new)
end

#UPDATE Expendature
post '/counting_pennies/:id' do
  Spending.new(params).update
  redirect to '/counting_pennies'
end

#SHOW INDIVIDUAL
get '/counting_pennies/:id' do
  @spending = Spending.find( params[:id] )
  erb( :show )
end

#CREATE NEW
post '/counting_pennies' do
  # if params['text_tag'] != ""
  @spending = Spending.new(params)
  @spending.save()
  erb( :create )
  # binding.pry()
end
