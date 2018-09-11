# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

cats = []
derek = Cat.create!(
  birth_date: "1994-04-04",
  color: 'grey',
  name: 'Derek',
  sex: 'M',
  description: 'The best cat'
)
cats << derek

jing = Cat.create!(
  birth_date: "1989-05-13",
  color: 'black and white',
  name: 'Jing',
  sex: 'F',
  description: 'The oddest cat'
)
cats << jing
