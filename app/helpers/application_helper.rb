module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Org-Org: Organization For Your Organization"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def errors_for(object, attribute)
    render partial: 'shared/form_field_errors', 
           locals: { errors: object.errors[attribute] }
  end
end