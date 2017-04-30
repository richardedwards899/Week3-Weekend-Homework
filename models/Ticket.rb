require_relative("../db/sqlRunner.rb")

class Ticket

  attr_accessor :customer_id, :screening_id, :price
  attr_reader :ticket_id

  def initialize( options )
    @ticket_id = options['ticket_id'].to_i if options['ticket_id'] 
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
    @price = options['price'].to_i
  end

  def save()
    sql = "
    INSERT INTO tickets (customer_id, screening_id, price) 
    VALUES (#{@customer_id}, #{@screening_id}, #{price}) 
    RETURNING ticket_id;"
    
    @ticket_id = SqlRunner.run(sql)[0]['ticket_id'].to_i
  end

  def update()
    sql = "
    UPDATE tickets 
    SET (customer_id, screening_id, price)
    = ( #{@customer_id}, #{@screening_id}, #{@price} )
    WHERE ticket_id = #{@ticket_id};"

    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets where ticket_id = #{@ticket_id};"
    SqlRunner.run(sql)
  end

  def Ticket.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def Ticket.find(ticket_id)
    sql = "SELECT * FROM tickets WHERE ticket_id = #{ticket_id};"
    return Ticket.new ( SqlRunner.run(sql)[0] )
  end

end