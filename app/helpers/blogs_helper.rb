module BlogsHelper
  def gravatar_helper user, style
    hash = Digest::MD5.hexdigest(user.email)
    image_tag "https://www.gravatar.com/avatar/#{hash}", width: 60, class: "#{style}"
  end
end
