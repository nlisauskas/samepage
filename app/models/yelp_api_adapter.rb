class YelpApiAdapter < ApplicationRecord
  # #Returns a parsed json object of the request

  def self.search(term, location)
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      location: location,
      limit: SEARCH_LIMIT,
      radius: 16093
    }
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    response.parse["businesses"]
  end

  def self.business_reviews(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}/reviews"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse["reviews"]
  end

  def business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end

end
