require_relative('../db/sql_runner')
require('pry-byebug')


class Spending

attr_accessor :id, :user, :tag_id, :merchant_id, :price, :product, :purchase_date, :user_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @user_id = options['user_id']
    @tag_id = options['tag_id']
    @merchant_id = options['merchant_id']
    @price = options['price']
    @product = options['product']
    @purchase_date = options['purchase_date']
  end

  def save()
    sql = 'INSERT INTO spendings (user_id, tag_id, merchant_id, price, product, purchase_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@user_id, @tag_id, @merchant_id, @price, @product, @purchase_date]
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


  def self.find( id )
    sql = "SELECT * FROM spendings
    WHERE id = $1"
    values = [id]
    spending = SqlRunner.run( sql, values ).first
    result = Spending.new( spending )
    return result
  end


  def delete()
    sql = "DELETE FROM spendings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def get_merchant()
    sql = 'SELECT * FROM merchants WHERE id = $1'
    values = [@merchant_id]
    result = SqlRunner.run(sql, values).first
    Merchant.new(result)
  end

  def get_tag()
    sql = 'SELECT * FROM tags WHERE id = $1'
    values = [@tag_id]
    result = SqlRunner.run(sql, values).first
    Tag.new(result)
  end

  def update()
    sql = 'UPDATE spendings
    SET
    (
      user_id,
      tag_id,
      merchant_id,
      price,
      product,
      purchase_date
    )
    =
    (
      $1, $2, $3, $4, $5, $6
      ) WHERE id = $7'
      values = [@user_id, @tag_id, @merchant_id, @price, @product, @purchase_date, @id]
      SqlRunner.run(sql, values)
  end

  def self.return_products
    sql = "SELECT product FROM spendings"
    result = SqlRunner.run(sql)
    hashes = result.map {|products| Spending.new(products)}
    hashes.map { |product| product.product}.uniq
  end


end
