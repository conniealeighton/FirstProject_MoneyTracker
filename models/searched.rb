require_relative('../db/sql_runner')
require('pry-byebug')


class Search

  attr_reader :id, :search

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @search = options['search']
  end

  def save()
    sql = 'INSERT INTO searches (search) VALUES ($1) RETURNING id'
    values = [@search]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM searches'
    results = SqlRunner.run(sql)
    results.map { |searched| Search.new(searched)}
  end

  def self.delete_all()
    sql = 'DELETE FROM searches'
    SqlRunner.run(sql)
  end

end
