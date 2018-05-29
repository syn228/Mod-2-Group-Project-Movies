# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

c1 = Character.create(name: "Ian", bio: "A neutral guy", alignment: "neutral")
c2 = Character.create(name: "Eelan", bio: "An evil gal", alignment: "villain")
c3 = Character.create(name: "Aaron", bio: "A heroic guy", alignment: "hero")

a1 = Actor.create(name: "Johnny Depp", bio: "Why is the rum gone?")
a2 = Actor.create(name: "Emma Watson", bio: "Hermoine?")
a3 = Actor.create(name: "Brad Pitt", bio: "It's Brad Pitt!")

m1 = Movie.create(name: "Adventures of Flatiron School", genre: "Adventure", budget: "15K", producer:"Rishi")

c1.actors << a1
c2.actors << a2
c3.actors << a3

a1.movies << m1
