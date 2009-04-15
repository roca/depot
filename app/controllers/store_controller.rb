#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class StoreController < ApplicationController
  
  def index
    @products = Product.find_products_for_sale
    @cart = find_cart

    @count = index_access_counter

  end
  


  
  
  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(product)
    session[:counter] = nil

    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}   
    end
    
   rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")
  end
  

def remove_from_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}" )
      redirect_to_index("Invalid product")
    else
      @cart = find_cart
      @current_item = @cart.remove_product(product)
      respond_to do |format|
        format.js if request.xhr?
        format.html { redirect_to_index("One #{product.title} was removed") }
      end
    end
  end

def save_order
    @cart = find_cart
    @order = Order.new(params[:order]) 
    @order.add_line_items_from_cart(@cart) 
    if @order.save                     
      session[:cart] = nil
      redirect_to_index("Thank you for your order")
    else
      render :action => 'checkout'
    end
  end

  
  def empty_cart
    session[:cart] = nil
     @cart = find_cart

    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}   
    end
    
   end
  
  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
    else
      @order = Order.new
    end
  end
private

  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end
  
  

  def find_cart
    session[:cart] ||= Cart.new
  end


def index_access_counter
  session[:counter] ||= 0
  session[:counter] += 1
end

end
