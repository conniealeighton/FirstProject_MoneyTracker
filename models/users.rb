require_relative('../db/sql_runner')

class User

  attr_reader :id, :first_name, :last_name, :goal, :spending_limit, :income


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @goal = options['goal']
    @spending_limit = options['spending_limit']
    @income = options['income']
  end

  def save()
    sql = 'INSERT INTO users (first_name, last_name, goal, spending_limit, income) VALUES ($1, $2, $3, $4, $5) RETURNING id'
    values = [@first_name, @last_name, @goal, @spending_limit, @income]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i()
  end

  def self.delete_all
    sql = 'DELETE FROM users'
    SqlRunner.run(sql)
  end

  def self.check_id
   sql = 'SELECT id FROM users'
   hash = SqlRunner.run(sql).first
   hash['id']
  end

end
