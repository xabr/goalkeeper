# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

User.destroy_all
Goal.destroy_all
Task.destroy_all

emails = ["carlos.baez.fumero@gmail.com", "x.briglmeier@gmail.com", "szczepanowska.n@gmail.com",
          "luizrmiug@gmail.com"]

users = [
  {
    email: "carlos.baez.fumero@gmail.com",
    goals: [
      {
        name: "Lose weight",
        description: "Pants don't fit anymore",
        category: "Health",
        task: [
          "Go to the gym",
          "Run 5 miles",
          "Count calories"
        ]
      },
      {
        name: "Play football",
        description: "Have some fun playing football again",
        category: "Sport",
        task: [
          "Sign up for an amateur game",
          "Watch tutorial on how to play football",
          "Buy a football"
        ]
      }
    ]
  },
  {
    email: "x.briglmeier@gmail.com",
    goals: [
      {
        name: "Drink More Water",
        description: "Keep myself hydrated",
        category: "Health",
        task: [
          "Drink 2 liters of water per day",
          "Buy a refillable bottle",
          "Download an app to track water intake"
        ]
      },
      {
        name: "Eat less sugar",
        description: "Be healthier with eating choices",
        category: "Health",
        task: [
          "Stop buying M&M's at the supermaket",
          "Replace industrial sugars with fruits",
          "Sugar cheat day on Fridays"
        ]
      }
    ]
  },
  {
    email: "szczepanowska.n@gmail.com",
    goals: [
      {
        name: "Swap careers",
        description: "Become a web dev",
        category: "Selfdevelopment",
        task: [
          "Sign up to a bootcamp",
          "Study 1h everyday",
          "Do flashcards"
        ]
      },
      {
        name: "Prepare Christmas gifts",
        description: "Start preparing family event",
        category: "Lifestyle Goals",
        task: [
          "Check Amazon",
          "Tell kids to write christmas list",
          "Buy wrapping paper"
        ]
      }
    ]
  },
  {
    email: "luizrmiug@gmail.com",
    goals: [
      {
        name: "Save some money",
        description: "2023 Holidays",
        category: "Finances",
        task: [
          "Put 1 euro in a jar everytime I insult Carlos",
          "Chech bank statement",
          "Stop ordering food"
        ]
      },
      {
        name: "Start playing chess",
        description: "Learn how to play the game",
        category: "Hobbys",
        task: [
          "Watch youtube tutorials",
          "Buy chess board",
          "Invite Friends to come over"
        ]
      }
    ]
  }
]

# Lifestyle Goals
# Hobbys
# 'Career'
# 'Education'
# Selfdevelopement
# 'Sport'
# 'Finances'
# 'Health'

# generate random users
puts "Creating users..."
users.each do |user_input|
  user = User.create(email: user_input[:email], password: "123456", user_name: Faker::Name.first_name)
  puts "Created #{user.user_name}"

  puts "Creating goals..."
  user_input[:goals].each do |goal_input|
    goal = Goal.create(name: goal_input[:name], description: goal_input[:description], category: "Sport",
                       status: "In Progress", user: user, start_date: Date.today,
                       end_date: Faker::Date.between(from: '2022-09-23', to: '2023-02-25'))
    puts "Created #{goal.name}"

    puts "Creating tasks..."
    goal_input[:tasks].each do |task_input|
      Task.create(name: task_input, status: "In Progress", goal_id: goal.id)
      puts "Created #{task.name}"
    end
  end
end

puts "Finished!"
