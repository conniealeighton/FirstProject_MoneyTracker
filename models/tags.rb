require_relative('../db/sql_runner')
require('pry-byebug')


class Tag

  attr_reader :id, :name

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

end
