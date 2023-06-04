# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'csv'

# Generate 676 products and store the data in an array
product_data = []
676.times do
  product = {
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..100.0),
    stock_quantity: Faker::Number.between(from: 0, to: 100),
    description: Faker::Lorem.sentence
  }
  product_data << product
end

# Clear products and categories tables
Product.destroy_all
Category.destroy_all

# Create categories
categories = []
product_data.each do |product|
  category_name = Faker::Commerce.department(max: 1)
  category = Category.find_or_create_by(name: category_name)
  categories << category
end

# Create products
product_data.each_with_index do |product, index|
  category = categories[index % categories.length]
  Product.create(
    title: product[:title],
    price: product[:price],
    stock_quantity: product[:stock_quantity],
    description: product[:description],
    category: category
  )
end
