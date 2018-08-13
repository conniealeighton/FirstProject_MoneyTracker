require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')


require_relative('./models/spendings')
require_relative('./models/users')
also_reload ( './models/*')

#INDEX ROUTE
get '/counting_pennies' do
  @spendings = Spending.all()
  #All user id's the same, get first ID
  @user_id = Spending.all[1].user_id
  erb(:home)
end

#EDIT
get '/counting_pennies/:id/edit' do
  @spending = Spending.find( params[:id])
  erb( :edit )
end

#DELETE
post '/counting_pennies/:id/delete' do
  order = Spending.find( params[:id])
  order.delete()
  redirect to '/counting_pennies'
end


#CREATE NEW
get '/counting_pennies/new/:id' do
  @user = User.find (params[:id])
  erb(:new)
end

#SHOW INDIVIDUAL
get '/counting_pennies/:id' do
  @spending = Spending.find( params[:id] )
  erb( :show )
end

#RETRIEVE NEW
post '/counting_pennies' do
  @spending = Spending.new( params )
  @spending.save()
  erb( :create )
end


#UPDATE
post 'counting_pennies/:id' do
  Spending.new(params).update
  redirect to '/counting_pennies'
end
