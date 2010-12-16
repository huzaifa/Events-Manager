module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Events Manager"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :width => 80, :height => 60, :alt => "Sample App", :class => "round")
  end

end
