# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"
require 'openssl'
silence_warnings do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE unless Rails.env.production?
end

puts "Cleaning database 🗑️"
Movie.destroy_all

puts "Getting Movies data 🎥"

def movies_dataset
  url = "https://tmdb.lewagon.com./movie/top_rated"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)
  # movies = RestClient.get("https://tmdb.lewagon.com./movie/top_rated")
  # movies_array = JSON.parse(movies)["results"]
  # puts movies_array
  movies_results = movies["results"]
  movies_results.each do |m|
    Movie.create(
      title: m["name"],
      overview: m["overview"],
      poster_url: m["poster_path"],
      rating: m["vote_average"]
    )
  end

end
movies_dataset()
puts "Seeding Movies Data 🌱"
