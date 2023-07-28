# db/seeds.rb

# Create users
first_user = User.create(name: 'Tom', photo: 'https://img.freepik.com/foto-gratis/feliz-joven_1098-20869.jpg?w=740&t=st=1689738009~exp=1689738609~hmac=5757be4c36da7b17920e83acece1487622aeb3b074b1cd30ca510073909f40db', email: 'tom@email.com', password: '123456', bio: 'Teacher from Mexico.', posts_counter: 0)
second_user = User.create(name: 'Lilly', photo: 'https://img.freepik.com/foto-gratis/retrato-hermoso-mujer-joven-posicion-pared-gris_231208-10760.jpg?w=740&t=st=1689738007~exp=1689738607~hmac=8b20e5cdb0ee3ec7d948332a9279376fcb01f6eb493d6272b807390e7df83fbb', email: 'lily@email.com', password: '123456', bio: 'Teacher from Poland.', posts_counter: 0)

# Create posts for the first user
first_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my second post')
third_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my third post')
fourth_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my fourth post')

# Create comments for the fourth post
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'Hi Tom!')
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'This is my second comment')
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'This is my third comment')
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'This is my fourth comment')
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'This is my fifth comment')
Comment.create(post_id: fourth_post.id, author_id: second_user.id, text: 'This is my sixth comment')
