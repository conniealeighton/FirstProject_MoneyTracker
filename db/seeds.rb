require_relative('../models/spendings')
require_relative('../models/users')
require_relative('../models/merchants')
require_relative('../models/tags')
require('pry-byebug')

Merchant.delete_all()
User.delete_all()
Spending.delete_all()
Tag.delete_all()




tag1 = Tag.new({ 'name' => 'Food'})
tag1.save()

tag2 = Tag.new ({'name' => 'Shopping'})
tag2.save()

merchant1 = Merchant.new({'name' => 'Tesco'})

merchant1.save()

merchant2 = Merchant.new ({'name' => 'New Look'})

merchant2.save()

user1 = User.new({'first_name' => 'Joe', 'last_name' => 'Doe', 'goal' => 'get out of debt', 'spending_limit' => 1000, 'income' => 16000})

user1.save()

spending1 = Spending.new({
  'user_id' => user1.id,
  'tag_id' => tag2.id,
  'merchant_id' => merchant1.id,
  'price' => 50,
  'product' => 'food',
  'purchase_date' => '2012-10-19 00:00:00'})

spending2 = Spending.new({
  'user_id' => user1.id,
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id,
  'price' => 40,
  'product' => 'food',
  'purchase_date' => '2012-10-19 00:00:00'})

spending3 = Spending.new({
  'user_id' => user1.id,
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'price' => 70,
  'product' => 'Bills and Electric', 'purchase_date' => '2012-10-19 00:00:00'})


spending1.save()
spending2.save()
spending3.save()
