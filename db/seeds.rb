require_relative('../models/spendings')
require_relative('../models/users')
require('pry-byebug')

User.delete_all()
Spending.delete_all()

user1 = User.new({'first_name' => 'Joe', 'last_name' => 'Doe', 'goal' => 'get out of debt', 'spending_limit' => 1000, 'income' => 16000})

user1.save()

spending1 = Spending.new({'user_id' => user1.id, 'tag' => 'Shopping', 'merchant' => 'Tesco', 'price' => 50, 'product' => 'food', 'purchase_date' => '2012-10-19 00:00:00'})

spending2 = Spending.new({'user_id' => user1.id, 'tag' => 'Shopping', 'merchant' => 'Waitrose', 'price' => 40, 'product' => 'food', 'purchase_date' => '2012-10-19 00:00:00'})

spending3 = Spending.new({'user_id' => user1.id, 'tag' => 'Bills', 'merchant' => 'EDF', 'price' => 70, 'product' => 'Bills and Electric', 'purchase_date' => '2012-10-19 00:00:00'})


spending1.save()
spending2.save()
spending3.save()

binding.pry
nil
