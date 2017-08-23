module ApplicationHelper

  def login_helper style=''
    if current_user.is_a?(GuestUser) 
      (link_to "Login", new_user_session_path, class: style ) +
      + " ".html_safe +
      (link_to "Register", new_user_registration_path, class: style )
      
   else 
      link_to "Logout", destroy_user_session_path, method: :delete, class: style 
   end 
  end

  def session_helper(layout_name)
     if session[:source] 
      greeting = "Thank you for visiting me from #{session[:source]}"
      content_tag(:p, greeting, class: "#{layout_name}-greetings")
     end 
  end


  def copyrights_generator
    SpotOnViewTool::Renderer.copyright "Marcin Szot", "All rights reserved"
  end

end
