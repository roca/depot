module StoreHelper


  def report_index_visits

      response = session[:counter] && session[:counter] != 0 ? "Back for your "+session[:counter].to_s+"th visit" : "Welcome!"

    if session[:counter] >= 5
      return response
    else
      return ""
    end
  end
end
