require_relative('../db/sql_runner')
require('pry-byebug')


class Spending

attr_reader :id, :user, :tag, :merchant, :price, :product, :purchase_date, :user_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @user_id = options['user_id']
    @tag = options['tag']
    @merchant = options['merchant']
    @price = options['price']
    @product = options['product']
    @purchase_date = options['purchase_date']
  end

  def save()
    sql = 'INSERT INTO spendings (user_id, tag, merchant, price, product, purchase_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@user_id, @tag, @merchant, @price, @product, @purchase_date]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end


  def self.delete_all()
    sql = 'DELETE FROM spendings'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM spendings'
    result = SqlRunner.run(sql)
    result.map { |spending| Spending.new(spending)}
  end


  def self.list_tags
    sql = 'SELECT tag FROM spendings'
    result = SqlRunner.run(sql)
    array = result.map { |spending| Spending.new(spending).tag }
    #'uniq' means there are no repeats
    return array.uniq
  end

  def self.list_merchants
    sql = 'SELECT merchant FROM spendings'
    result = SqlRunner.run(sql)
    array = result.map { |spending| Spending.new(spending).merchant}
    return array.uniq
  end

  def self.find( id )
    sql = "SELECT * FROM spendings
    WHERE id = $1"
    values = [id]
    spending = SqlRunner.run( sql, values ).first
    result = Spending.new( spending )
    return result
  end


end
