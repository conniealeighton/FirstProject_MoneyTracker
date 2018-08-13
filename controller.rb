require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')


require_relative('./models/spendings')
require_relative('./models/users')
also_reload ( './models/*')

#INDEX ROUTE
get '/counting_pennies' do
  @spendings = Spending.all()
  erb(:home)
end

#NEW EXPENDITURE
get '/counting_pennies/new' do
  @user = User.check_id
  @tags = Spending.list_tags
  @merchants = Spending.list_merchants
  erb (:new)
end


post '/counting_pennies' do
  @spending = Spending.new(params)
  @spending.save()
  @spending = Spending.insert_id
  erb(:joined)
end
