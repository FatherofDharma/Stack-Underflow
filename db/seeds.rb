require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Topic.destroy_all
Post.destroy_all

5.times do
  user_name = Faker::Artist.name
  user = User.new(:user_name => user_name)
  5.times do
    topic_title = Faker::Cosmere.aon
    new_topic = user.topics.new(:title => topic_title)
    new_topic.save
    5.times do
      post_body = Faker::GreekPhilosophers.quote
      new_post = new_topic.posts.new(:content_body => post_body)
      new_post.save
    end
  end
end
