require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |index|
    coupons.each do |coup_index|
      if coup_index[:item] == index[:item] && index[:count] >= coup_index[:num]
        cart << {
            :item => "#{index[:item]} W/COUPON",
            :price => (coup_index[:cost]/coup_index[:num]),
            :clearance => index[:clearance],
            :count => coup_index[:num]
                }
        index[:count] -= coup_index[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  applied_clearance = cart.each_with_object([]) do |index,discount_array|
    if index[:clearance] == true && index[:price] > 0
      index[:price] = ((index[:price]*index[:count]*(0.80))/index[:count]).round(2)
      discount_array<<index
    else
      discount_array<<index
    end
  end
  applied_clearance
end

cart1 = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons1 = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

unconsolidated_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE",    :price => 3.00, :clearance => false},
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]
def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  a = consolidate_cart(cart)
  b = apply_coupons(a,coupons)
  c = apply_clearance(b)

  prices = c.each_with_object([]) do |index,price_array|
    if index[:count] != 0
      price_array << index[:price]*index[:count]
    end
  end
  if prices.sum > 100
    prices.sum*0.90
  else
    prices.sum
  end
end
