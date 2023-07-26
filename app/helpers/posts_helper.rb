module PostsHelper
  def render_text_section(post)
    content_tag(:div, class: 'text') do
      concat content_tag(:p, "Comments: #{post.comments_counter.nil? ? 0 : post.comments_counter}",
                         class: 'comment-text')
      concat link_to 'Likes: ', increment_likes_path(post), method: :post, remote: true, class: 'like-counter',
                                                            id: "like-link-#{post.id}"
      concat content_tag(:span, post.likes_counter.nil? ? 0 : post.likes_counter, class: 'like-counter-number',
                                                                                  id: "like-counter-#{post.id}")
    end
  end

  def render_comments_section(post)
    content_tag(:div, class: 'comments-section') do
      content_tag(:h4, 'Comments:', class: 'section-comments') +
        if post.comments.blank?
          content_tag(:p, 'no comments for the moment', class: 'ul-comments-box')
        else
          content_tag(:ul, class: 'ul-comments-box') do
            post.comments.each do |comment| # Loop through each comment associated with the post
              user_name = comment.user ? comment.user.name : 'Anonymous' # Get the name of the user who made the comment
              concat content_tag(:li, "#{user_name}: #{comment.text}")
            end
          end
        end
    end
  end
end
