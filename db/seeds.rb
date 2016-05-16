admin      = User.create(username: "admin_bob", role: "admin", password: "adminpassword123")
splinter   = Character.create(name: "Teacher Splinter", health: 50, strength: 10, user: admin)
  
user1      = User.create(username: "with_pager", role: "user", password: "superhackypass")
donatello  = Character.create(name: "Donatello", health: 80, strength: 12, user: user1)

user2      = User.create(username: "gambit", role: "user", password: "ytdcrhjtnt5")
leonardo   = Character.create(name: "Leonardo", health: 75, strength: 15, user: user2)

Comment.create(user: user1, character: splinter, body: "Why are you that week master Splinter? ;)")
Comment.create(user: admin, character: splinter, body: "He is old and week but wise! Guess admins should add this attribute soon...")

Comment.create(user: user2, character: donatello, body: "WOW this one looks just like Leonardo of mine! Wanna make a turtle band?")
