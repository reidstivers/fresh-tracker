module ApplicationHelper
  def render_navbar?
    !(controller_name == 'pages' && action_name == 'home')
  end
end
