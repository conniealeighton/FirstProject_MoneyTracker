require_relative('../db/sql_runner')
require('pry-byebug')


class Tag

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = 'INSERT INTO tags (name) VALUES ($1) RETURNING id'
    values = [@name]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM tags'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM tags'
    results = SqlRunner.run(sql)
    results.map { |tag| Tag.new(tag)}
  end

  def self.find( id )
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    tag = SqlRunner.run( sql, values ).first
    result = Tag.new( tag )
    return result
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.return_name(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    result.map { |name| Tag.new(name)}.first.name
  end

  def self.search_tags(search_item)
    sql = "SELECT * FROM tags WHERE name LIKE $1"
    search_item = "%" + search_item + "%"
    values = [search_item]
    result = SqlRunner.run(sql, values)
    result.map { |spending| Tag.new(spending)}
  end

  def self.search(search_item)
    sql = "SELECT * FROM spendings WHERE product LIKE $1"
    search_item = "%" + search_item + "%"
    values = [search_item]
    result = SqlRunner.run(sql, values)
    result.map { |spending| Spending.new(spending)}
  end

  def self.spending_from_tag(id)
    sql = "SELECT * FROM spendings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    result.map { |spending| Spending.new(spending)}.first
  end

end
