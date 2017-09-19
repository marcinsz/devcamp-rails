module BlogsHelper
  def gravatar_helper user, style
    hash = Digest::MD5.hexdigest(user.email)
    image_tag "https://www.gravatar.com/avatar/#{hash}", width: 60, class: "#{style}"
  end

  class  CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)

    options ={
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
    }

    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end


  def blog_color_status(blog)
      "color: red" if blog.draft?
  end

end
