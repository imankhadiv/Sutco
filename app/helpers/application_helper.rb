module ApplicationHelper
  def nav_link_to(current_identifier, *args, &block)
    identifier = block_given? ? args[1].delete(:identifier) : args[2].delete(:identifier)
    content_tag :li, class: (:active if identifier == current_identifier) do
      link_to(*args, &block)
    end
  end

  def navbar_link_to(*args, &block)
    nav_link_to(@current_nav_identifier, *args, &block)
  end
  def subnav_link_to(*args, &block)
    nav_link_to(@current_subnav_identifier, *args, &block)
  end
  
  def no_record_tr(colspan, text = 'No records to display')
    content_tag(:tr, content_tag(:td, text, colspan: colspan, class: 'text-center text-muted' ), class: 'tr-no-record')
  end
  def link_to_icon(icon_name, url_or_object, options={})
    link_to(("<i class=#{icon_name}></i>".html_safe),
     url_or_object,
    options )
  end




  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end




end
