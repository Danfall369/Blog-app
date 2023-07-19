module UsersHelper
  def user_details_for(user)
    content_tag(:div, class: 'user-details') do
      concat(content_tag(:h2, link_to(user.name, user_path(user), class: 'custom-link')))
      concat(content_tag(:p, "Number of posts: #{user.posts_counter}", class: 'user-posts-counter'))
    end
  end
end
