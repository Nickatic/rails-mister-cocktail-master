# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
puts "cleaning db"
Ingredient.destroy_all
Dose.destroy_all
Cocktail.destroy_all
puts "db cleaned"

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
doc = open(url).read
json = JSON.parse(doc)
puts "seeding ingredients"
json["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
puts "ingredients done"
puts "fetching cocktail id"
url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
doc = open(url).read
json = JSON.parse(doc)
id_array = []
json["drinks"].each do |cocktail|
  id_array << cocktail["idDrink"]
end
puts "cocktail ids found"
puts "seeding doses and cocktails"
id_array.each do |id|
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
  doc = open(url).read
  json = JSON.parse(doc)
  name = json["drinks"][0]["strDrink"]
  instruction = json["drinks"][0]["strInstructions"]
  photo_url = json["drinks"][0]["strDrinkThumb"]
  Cocktail.create!(name: name, instruction: instruction, photo_url: photo_url)
  @cocktail = Cocktail.last
  15.times do |count|
    if !json["drinks"][0]["strIngredient#{count+1}"].blank?
      ingredient = json["drinks"][0]["strIngredient#{count+1}"]

      if !Ingredient.find_by_name(ingredient).blank?
        ingredient_id = Ingredient.find_by_name(ingredient).id
        description = json["drinks"][0]["strMeasure#{count+1}"]
        Dose.create!(description: description, ingredient_id: ingredient_id, cocktail_id: @cocktail.id)
      else
        @ingredient = Ingredient.create(name: ingredient)
        description = json["drinks"][0]["strMeasure#{count+1}"]
        Dose.create!(description: description, ingredient_id: @ingredient.id, cocktail_id: @cocktail.id)
      end
    end
  end

end
puts "finished"

