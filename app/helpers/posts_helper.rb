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
            post.comments.each do |comment|
              user_name = comment.user ? comment.user.name : 'Anonymous'
              comment_text = "#{user_name}: #{comment.text}"
              delete_link = if current_user == post.user || can?(:delete, comment)
                              button_to('Delete', delete_comment_path(comment.user, post, comment),
                                        method: :delete,
                                        data: { turbo_method: :delete, turbo_confirm: 'Delete Comment?' },
                                        class: 'Delete-button')
                            end

              concat content_tag(:li, "#{comment_text} #{delete_link}".html_safe, class: 'comment-li')
            end
          end
        end
    end
  end
end
