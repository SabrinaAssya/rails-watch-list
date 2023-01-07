# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'rest-client'

puts "Getting Movies data 🎥"

def movies_dataset
  movies = RestClient.get("https://tmdb.lewagon.com./movie/top_rated")
  movies_array = JSON.parse(movies)["results"]
  movies_array.each do |m|
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
