require( 'pry-byebug' )

require_relative('../models/Customer')
require_relative('../models/Film')
require_relative('../models/Ticket')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'Richard',
  'funds' => 50
  })
customer2 = Customer.new({
  'name' => 'Frankie',
  'funds' => 100
  })

customer1.save
customer2.save
# customer1.delete

film1 = Film.new({
  'title' => 'The Hunt For Red October',
  'director' => 'John McTiernan'
  })
film2 = Film.new({
  'title' => 'Labyrinth',
  'director' => 'George Lucas'
  })

film1.save
film2.save
# film1.delete

ticket1 = Ticket.new({
  'customer_id' => customer1.customer_id,
  'film_id' => film1.film_id,
  'price' => 10
  })
ticket2 = Ticket.new({
  'customer_id' => customer1.customer_id,
  'film_id' => film2.film_id,
  'price' => 5
  })
ticket3 = Ticket.new({
  'customer_id' => customer2.customer_id,
  'film_id' => film2.film_id,
  'price' => 5
  })

ticket1.save
ticket2.save
ticket3.save
# ticket2.delete

customer1.buy_ticket(ticket1)
customer1.buy_ticket(ticket2)
customer2.buy_ticket(ticket3)









binding.pry
nil
