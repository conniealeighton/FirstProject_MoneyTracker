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
  erb(:home)
end

#GET NEW TAG
get '/counting_pennies/tag/new' do
  erb(:new_tag)
end



# TAG INDEX
get '/counting_pennies/tag' do
  @tags = Tag.all()
  erb(:tag)
end


#CREATE NEW TAG
post 'counting_pennies/tag' do
  @tags = Tag.new( params )
  @tags.save()
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
  @spending = Spending.new(params)
  @spending.save()
  erb( :create )
end
