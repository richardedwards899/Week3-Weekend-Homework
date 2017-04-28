require_relative("../db/sqlRunner.rb")

class Film

  attr_accessor :title, :director
  attr_reader :film_id

  def initialize( options )
    @film_id = options['film_id'].to_i if options['film_id'] 
    @title = options['title']
    @director = options['director']
  end

  def save()
    sql = "
    INSERT INTO films (title, director) 
    VALUES ('#{ @title }', '#{@director}') RETURNING film_id;"
    
    film_hash = SqlRunner.run(sql)[0]
    @film_id = film_hash['film_id'].to_i
  end

  def update()
    sql = "
    UPDATE films 
    SET (title, director) 
    = ('#{@title}', '#{@director}')
    WHERE film_id = #{@film_id};"

    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films where film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def customers()
    sql =
    "SELECT * FROM tickets t INNER JOIN customers c
    ON t.customer_id = c.customer_id
    WHERE t.film_id = #{@film_id};"

    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map() {|customer_hash| Customer.new(customer_hash)}
  end

  def number_of_customers()
    return customers.count
  end

  def Film.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def Film.find(film_id)
    sql = "SELECT * FROM films WHERE film_id = #{film_id};"
    return Film.new ( SqlRunner.run(sql)[0] )
  end

end