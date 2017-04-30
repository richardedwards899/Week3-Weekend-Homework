require( 'pry-byebug' )

require_relative('../models/Customer')
require_relative('../models/Film')
require_relative('../models/Ticket')
require_relative('../models/Screening')

#load data from database
customer1 = Customer.find(1)
customer2 = Customer.find(2)
customer3 = Customer.find(3)
customer4 = Customer.find(4)

ticket1 = Ticket.find(1)
ticket2 = Ticket.find(2)
ticket3 = Ticket.find(3)
ticket4 = Ticket.find(4)
ticket5 = Ticket.find(5)

screening1 = Screening.find(1)
screening2 = Screening.find(2)
screening3 = Screening.find(3)
screening4 = Screening.find(4)
screening5 = Screening.find(5)

film1 = Film.find(1)
film2 = Film.find(2)
film3 = Film.find(3)
film4 = Film.find(4)

binding.pry
nil















# The greyed out code below was used to test the Ticket, Film and Customer classes.
# Customer.delete_all()
# Film.delete_all()
# Ticket.delete_all()
# Screening.delete_all()

# customer1 = Customer.new({
#   'name' => 'Richard',
#   'funds' => 50
#   })
# customer2 = Customer.new({
#   'name' => 'Frankie',
#   'funds' => 100
#   })

# film1 = Film.new({
#   'title' => 'The Hunt For Red October',
#   'director' => 'John McTiernan'
#   })
# film2 = Film.new({
#   'title' => 'Labyrinth',
#   'director' => 'George Lucas'
#   })

# screening1 = Screening.new({
#   'film_id' => film1.film_id,
#   'screening_time' => '21:00',
#   'max_seats' => 100
#   })

# screening2 = Screening.new({
#   'film_id' => film1.film_id,
#   'screening_time' => '22:30',
#   'max_seats' => 100
#   })

# ticket1 = Ticket.new({
#   'customer_id' => customer1.customer_id,
#   'film_id' => film1.film_id,
#   'price' => 10
#   })
# ticket2 = Ticket.new({
#   'customer_id' => customer1.customer_id,
#   'film_id' => film2.film_id,
#   'price' => 5
#   })

