require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart=cart
  coupons.each do |coupon_item|
    cart.each do |cart_item|
      if cart_item[:item] == coupon_item[:item]
        if cart_item[:count] >= coupon_item[:num]
          cart_item[:count] = cart_item[:count] - coupon_item[:num]
          discounted_price = coupon_item[:cost] / coupon_item[:num]
          discounted_item = {:item => cart_item[:item] + ' W/COUPON', :price => discounted_price, :clearance => cart_item[:clearance], :count => coupon_item[:num]}
          new_cart << discounted_item
        end
      
      end  
    end  
  end
  return new_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = []
  cart.each do |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] = (cart_item[:price] * (0.8)).round(2)
    end
    new_cart << cart_item
  end
  return new_cart
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
  consolidated_cart = consolidate_cart(cart)
  applied_coupons_to_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(applied_coupons_to_cart)
  total_price = 0
  final_cart.each do |final_items|
    item_total_price = final_items[:count] * final_items[:price]
    total_price = total_price + item_total_price
  end
  if total_price > 100
    total_price = total_price * 0.9
  end
  return total_price
  
  
end
unconsolidated_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 3}]

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 4},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 3}]
coupon = [
  
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "KALE",    :num => 1, :cost => 1.22}
  
  
  ]

#consolidate_cart(unconsolidated_cart)
#apply_coupons(cart, coupon)
#apply_clearance(cart)
checkout(unconsolidated_cart, coupon)


