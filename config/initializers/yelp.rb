require "json"
require "http"

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
API_KEY = ENV["YELP_API"]

DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "contractors"
DEFAULT_LOCATION = "Chicago"
SEARCH_LIMIT = 10
