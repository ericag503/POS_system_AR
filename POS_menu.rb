require 'active_record'

require './lib/cashier'
require './lib/product'
require './lib/sale'
require './lib/purchase'

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
      "sorry not a valid option"
    end
  end
end

def add_product
  puts "Enter the product name"
  product_input = gets.chomp
  puts "Enter the product price"
  product_price = gets.chomp.to_i
  Product.create(:name => product_input, :price => product_price)
  puts "#{product_input} has been added"
end

welcome
