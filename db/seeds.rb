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
products = []
676.times do
  product = {
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..100.0),
    stock_quantity: Faker::Number.between(from: 0, to: 100)
  }
  products << product
end

# Clear products and categories tables
Product.destroy_all
Category.destroy_all

# Read data from CSV file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

# Loop through CSV rows and create categories and products
products.each do |row|
  category_name = row['category']
  category = Category.find_or_create_by(name: category_name)

  product = Product.create(
    title: row['title'],
    price: row['price'],
    stock_quantity: row['stock_quantity'],
    category: category
  )
end


