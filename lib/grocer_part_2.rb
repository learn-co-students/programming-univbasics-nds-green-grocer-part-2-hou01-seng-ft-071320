require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  coupons.each do |i|
    index = 0 
    while index < coupons.length
      cart.each do |j|
        if j[:count] >= i[:num] && i[:item] == j[:item]
          discounted = {item: j[:item] + " W/COUPON", price: i[:cost] / i[:num], clearance: j[:clearance], count: j[:count] - (j[:count] % i[:num])}
          cart.push(discounted)
          diff = j[:count] - i[:num]
          if diff < 1 
            j[:count] = 0
            # cart.shift()
          elsif diff == 1
            j[:count] = diff
          end
        end
      end
      index += 1
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |i|
    if i[:clearance] == true 
      i[:price] = i[:price] - (i[:price] * 0.20)
    end
  end
end

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
  
  total = 0
  checkout_cart = []
  checkout_cart = consolidate_cart(cart)

  checkout_cart = apply_coupons(checkout_cart, coupons)
  
  checkout_cart = apply_clearance(checkout_cart)
  
  checkout_cart.each do |i|
    total = total + (i[:price]  * i[:count])
    total = total.round(2)
  end

  if total > 100
    total = total - (total * 0.1)
  end
  total.round(2)
end
