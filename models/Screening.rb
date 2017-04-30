require_relative("../db/sqlRunner.rb")

class Screening

  attr_accessor :film_id, :screening_time, :max_seats
  attr_reader :screening_id

  def initialize( options )
    @screening_id = options['screening_id'] if options['screening_id'] 
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time']
    @max_seats = options['max_seats'].to_i
  end

  def save()
    sql = "
    INSERT INTO screenings (screening_time, max_seats) 
    VALUES ( TIME '#{ @screening_time }', #{@max_seats}) RETURNING film_id;"
    
    @screening_id = SqlRunner.run(sql)[0]['screening_id'].to_i
  end

  def update()
    sql = "
    UPDATE screenings 
    SET (screening_time, max_seats) 
    = (TIME '#{@screening_time}', #{@max_seats})
    WHERE screening_id = #{@screening_id};"

    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM screenings where screening_id = #{@screening_id};"
    SqlRunner.run(sql)
  end

  def tickets()
    sql = "
      select t.* from tickets t
      inner join screenings s on s.screening_id = t.screening_id
      where s.screening_id = #{@screening_id};
      "
    array_of_ticket_hashes = SqlRunner.run(sql)
    return array_of_ticket_hashes.map() {|ticket_hash| Ticket.new(ticket_hash)}
  end

  def number_of_tickets()
    return tickets.count
  end

  def Screening.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

  def Screening.find(screening_id)
    sql = "SELECT * FROM screenings WHERE screening_id = #{screening_id};"
    return Screening.new ( SqlRunner.run(sql)[0] )
  end

end