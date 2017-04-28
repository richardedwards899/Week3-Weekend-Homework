require_relative("../db/sqlRunner.rb")

class Customer

  attr_accessor :name, :funds
  attr_reader :customer_id

  def initialize( options )
    @customer_id = options['customer_id'].to_i if options['customer_id'] 
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "
    INSERT INTO customers (name, funds) 
    VALUES ('#{ @name }', #{@funds}) RETURNING customer_id;"
    
    customer_hash = SqlRunner.run(sql)[0]
    @customer_id = customer_hash['customer_id'].to_i
  end

  def update()
    sql = "UPDATE customers 
    SET (name, funds) 
    = ('#{@name}', #{@funds})
    WHERE customer_id=#{@customer_id};"

    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers where customer_id = #{@customer_id};"
    SqlRunner.run(sql)
  end

  def films()
    sql =
    "SELECT * FROM tickets t
    INNER JOIN films f
    ON f.film_id = t.film_id
    WHERE t.customer_id = #{@customer_id};"

    # Alternative query - works the same
    # sql = "
    # SELECT * FROM films f
    # INNER JOIN tickets t
    # ON f.film_id = t.film_id
    # WHERE t.customer_id = #{@customer_id}    
    # "

    film_hashes = SqlRunner.run(sql)
    return film_hashes.map() {|film_hash| Film.new(film_hash)}
  end

  def buy_ticket(ticket)
    @funds -= ticket.price
    self.update
  end

  def number_of_tickets()
    sql =
    "SELECT * FROM tickets t
    WHERE t.customer_id = #{@customer_id};"

    ticket_hashes = SqlRunner.run(sql)
    tickets = ticket_hashes.map() { |ticket| Ticket.new(ticket) }
    return tickets.size    
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def Customer.find(customer_id)
    sql = "SELECT * FROM customers WHERE customer_id = #{customer_id};"
    return Customer.new ( SqlRunner.run(sql)[0] )
  end

end