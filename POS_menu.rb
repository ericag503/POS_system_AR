require 'active_record'

require './lib/cashier'
require './lib/product'
require './lib/sale'
require './lib/purchase'
require './lib/customer'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

def welcome
  puts "***POS-SYSTEM***"
  menu
end


def menu
choice = nil
  until choice == 'x'
    puts "Press [1] for the store manager menu"
    puts "Press [2] for the cashier menu"
    puts "Press [3] for the customer menu"
    puts "Press [x] to exit the program"
    choice = gets.chomp
    case choice
    when '1'
      manager_menu
    when '2'
      cashier_menu
    when '3'
      customer_menu
    when 'x'
      exit
    else
      "Sorry, not a valid option."
    end
  end
end

def cashier_menu
puts "MAKE A SALE!"
    choice = nil
    until choice == 'x'
      puts "Press [1] to create a new sale"
      puts "Press [2] to login as a different cashier"
      puts "Press [r] to return to the main menu"
      choice = gets.chomp
      case choice
      when '1'
        create_sale
      when '2'
        cashier_menu
      when 'r'
        menu
      else
        puts "Not a valid option"
      end
    end
  end

def create_sale
  puts "Please enter your name to login:"
  entry = gets.chomp
  new_cashier = Cashier.find_by(:name => entry)
  puts "#{new_cashier.name} has been logged in"

  puts "Please enter the customer name for this sale"
  customer_name = gets.chomp
  new_customer = Customer.create(:name => customer_name)
  new_sale = Sale.create(:cashier_id => new_cashier.id , :customer_id => new_customer.id)
  new_customer.sales << new_sale
  new_cashier.sales << new_sale


  loop do
  list_product
  puts "Enter the name of the product you would like to sell"
  product_input = gets.chomp
  new_product = Product.find_by(:name => product_input)
  puts "#{product_input} has been added to your cart"
  new_purchase = Purchase.create(:product_id => new_product.id, :sale_id => new_sale.id)
  new_product.purchases << new_purchase
  puts "Press [c] to checkout or press [enter] to add to another sale."
  input = gets.chomp
  if input == 'c'
    check_out
  end
end
end

def check_out
  total = 0.0
  Purchase.all.each do |purchase|
    puts "#{purchase.product.name} #{purchase.product.price}"
    total += purchase.product.price
  end
  puts "total = $#{total}"
end






def manager_menu
  choice = nil
  until choice == 'x'
   puts "Press [1] to add a product"
   puts "Press [2] to list all products"
   puts "Press [3] to add a cashier"
   puts "Press [r] to return the the main menu"
   choice = gets.chomp
   case choice
   when '1'
     add_product
   when '2'
     list_product
   when '3'
    add_cashier
   when 'r'
      menu
   else
      "Sorry, not a valid entry."
    end
  end
end

def add_product
  puts "Enter the product name"
  product_input = gets.chomp
  puts "Enter the product price"
  product_price = gets.chomp.to_f
  Product.create(:name => product_input, :price => product_price)
  puts "#{product_input} has been added"
end

def list_product
  puts " Here is a list of your products:"
  Product.all.each do |product|
    puts "#{product.name} $#{product.price}"
  end
end

def add_cashier
  puts "enter your new cashier name:"
  new_cashier_input = gets.chomp
  Cashier.create(:name => new_cashier_input)
  puts "#{new_cashier_input} has been added to the list of cashiers"
end





welcome
