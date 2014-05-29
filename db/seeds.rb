# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create( username: "chris", password: "superman")
User.create( username: "demo", password: "password")
User.create( username: "test1", password: "superman")
User.create( username: "test2", password: "superman")
User.create( username: "test3", password: "superman")
User.create( username: "test4", password: "superman")
User.create( username: "test5", password: "superman")
User.create( username: "test", password: "password")


Post.create( title: "Whatcha doin?", url: "http://i.imgur.com/kijXP0K.jpg", user_id: 3)
Post.create( title: "angry cat", url: "http://i.imgur.com/Uek5LUD.jpg", user_id: 1)
Post.create( title: "conviction cat", url: "http://i.imgur.com/SpCbHBI.jpg", user_id: 1)
Post.create( title: "waterfall", url: "http://ppcdn.500px.org/71174873/a2a4a29222991f2e66e77f77e9958f90229ae688/2048.jpg", user_id: 1)
Post.create( title: "aww cat", url: "http://i.imgur.com/evurnyI.jpg", user_id: 1)
Post.create( title: "pizza fries", url: "http://i.imgur.com/5ywsGIw.jpg", user_id: 1)
Post.create( title: "kangaroo", url: "http://i.imgur.com/cQ5E4ID.jpg", user_id: 2)
Post.create( title: "ESPN", url: "http://www.espn.com", body: "Sport News Website", user_id: 2)
Post.create( title: "google", url: "http://www.google.com", body: "search engine", user_id: 2)
Post.create( title: "Low pressure condensation", url: "http://i.imgur.com/1vLQ1vj.jpg", user_id: 5)
#Post.create( title: "", url: "", user_id: 1)

Vote.create( user_id: 1, post_id: 1, value: 1)
Vote.create( user_id: 2, post_id: 1, value: 1)
Vote.create( user_id: 1, post_id: 2, value: -1)
Vote.create( user_id: 2, post_id: 2, value: 1)
Vote.create( user_id: 1, post_id: 3, value: 1)
Vote.create( user_id: 3, post_id: 1, value: 1)
Vote.create( user_id: 4, post_id: 1, value: 1)
Vote.create( user_id: 5, post_id: 1, value: 1)

Comment.create( user_id: 1, body: "Parent Comment", post_id: 1)
Comment.create( user_id: 1, parent_id: 1, body: "Child Comment", post_id: 1)
Comment.create( user_id: 1, parent_id: 2, body: "Child Child Comment", post_id: 1)
Comment.create( user_id: 1, body: "Recursive Nested Comments!", post_id: 1)
Comment.create( user_id: 1, parent_id: 4, body: "[comment deleted by chris]", post_id: 1)