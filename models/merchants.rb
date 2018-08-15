require_relative('../db/sql_runner')
require('pry-byebug')


class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = 'INSERT INTO merchants (name) VALUES ($1) RETURNING id'
    values = [@name]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM merchants'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    result = SqlRunner.run(sql)
    result.map {|merchant| Merchant.new(merchant)}
  end

  def self.find( id )
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run( sql, values ).first
    result = Merchant.new( merchant )
    return result
  end

  def self.return_merchants
    sql = "SELECT name FROM merchants"
    result = SqlRunner.run(sql)
    hashes = result.map {|merchants| Merchant.new(merchants)}
    hashes.map { |merchants| merchants.name}
  end

  def self.return_name(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    result.map { |merchant| Tag.new(merchant)}.first.name
  end

  def self.search_merchants(search_item)
    sql = "SELECT * FROM merchants WHERE name LIKE $1"
    search_item = "%" + search_item + "%"
    values = [search_item]
    result = SqlRunner.run(sql, values)
    result.map { |spending| Merchant.new(spending)}
  end


end
