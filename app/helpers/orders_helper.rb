module OrdersHelper
  def link_to_add_fields(name, f, association)
    new_object = OrderItem.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields, :f => builder")
    end
    
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
end
