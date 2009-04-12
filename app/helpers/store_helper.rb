module StoreHelper


  def report_index_visits

      response = session[:counter] && session[:counter] != 0 ? "Back for your "+session[:counter].to_s+"th visit" : "Welcome!"

    if session[:counter] >= 5
      return response
    else
      return ""
    end
  end
  
  
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
    attributes["style" ] = "display: none"
  end
    content_tag("div" , attributes, &block)
  end
end
