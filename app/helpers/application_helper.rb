# -*- encoding : utf-8 -*-

module ApplicationHelper

  def days_since(old_date)
    (Date.today - old_date).to_i
  end

  def clean_characters(input)
    unless input.nil?
  	  input.gsub("â€™","'").gsub("â€œ","").gsub("&"," and ").gsub("  "," ").gsub("Ã±o","ñ")
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
