# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Student.destroy_all
Sensei.destroy_all
Dojo.destroy_all

@cobra = Dojo.create!(name: 'Cobra Kai', motto: 'Strike first. Strike hard. No mercy.')
@john = Sensei.create!(
  name: 'John Kreese',
  image_url: 'https://i.pinimg.com/originals/98/60/73/9860734188ab14fcbb16e72f5dd2ad86.jpg',
  wise_quote: 'We do not train to be merciful here. Mercy is for the weak. Here, in the streets, in competition: A man confronts you, he is the enemy.',
  dojo: @cobra
)
@johnny = Sensei.create!(
  name: 'Johnny Lawrence',
  image_url: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cobra-k-1526581667.jpg?resize=480:*',
  wise_quote: "I'm gonna teach you the style of karate that was taught to me. A method of fighting your pansy-ass generation desperately needs. I'm not just gonna teach you how to conquer your fears. I'm gonna teach you how to awaken the snake within you. And once you do that, you'll be the one who's feared. You'll build strength. You'll learn discipline. And when the time is right, you'll fight back.",
  dojo: @cobra
)

@miyagi_do = Dojo.create!(name: 'Miyagi-do', motto: 'Inner peace, focus, balance.')
@miyagi = Sensei.create!(
  name: 'Mr. Miyagi',
  image_url: 'https://costumewall.com/wp-content/uploads/2018/10/mr-miyagi.jpg',
  wise_quote: 'For man with no forgiveness in heart, life worse punishment than death',
  dojo: @miyagi_do
)
@daniel = Sensei.create!(
  name: 'Daniel LaRusso',
  image_url: 'https://www.indiewire.com/wp-content/uploads/2018/06/02_CobraKai.jpg?w=780',
  wise_quote: 'Karate lies in the mind and heart. Not in the hands.',
  dojo: @miyagi_do
)

puts "#{Dojo.count} dojos created!"
puts "#{Sensei.count} sensei created!"

Student.destroy_all

Student.create!(name:"Brian Danger", age: 33, special_attack:"Failing Upwards", sensei: @john)
Student.create!(name:"Bobby Talley", age: 95, special_attack:"The Mem-Fist Tenesseeya Later", sensei: @johnny)
Student.create!(name:"David Whitlatch", age: 15, special_attack:"The David Whiplash", sensei: @miyagi)
Student.create!(name:"Maddy Rombes", age: 25, special_attack:"The Rom-Bee Sting", sensei: @daniel)
puts "#{Student.count} students created!"