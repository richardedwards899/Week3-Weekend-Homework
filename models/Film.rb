require_relative("../db/sqlRunner.rb")
require( 'pry-byebug' )


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
    
    @film_id = SqlRunner.run(sql)[0]['film_id'].to_i
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
    sql = "
      select c.* from customers c
      inner join tickets t on c.customer_id = t.customer_id
      inner join screenings s on t.screening_id = s.screening_id
      inner join films f on s.film_id = f.film_id
      where f.film_id = #{@film_id}
    ;"

    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map() {|customer_hash| Customer.new(customer_hash)}
  end

  def number_of_customers()
    return customers.count
  end

  def most_popular_time()
    most_popular_screening = most_popular_screening()
    return "#{most_popular_screening.screening_time}"
  end

  def most_popular_screening()
    #get all the screenings for this film
    sql = "
      select s.* from films f
      inner join screenings s on s.film_id = f.film_id
      where f.film_id = #{@film_id}
    ;"

    screening_hashes = SqlRunner.run(sql)
    screenings = screening_hashes.map() {|screening_hash| Screening.new(screening_hash) }

    max_index = 0
    max_tickets = screenings[max_index].number_of_tickets

    for i in 1...screenings.length
      if screenings[i].number_of_tickets > max_tickets
        max_tickets = screenings[i].number_of_tickets
        max_index = i 
      end
    end

    return screenings[max_index]
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