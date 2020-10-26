module ApplicationHelper


  def navbar_link_to(*args, &block)
    content_tag :li do
      link_to(*args, &block)
    end
  end


  def no_record_tr(colspan, text = 'No records to display')
    content_tag(:tr, content_tag(:td, text, colspan: colspan, class: 'text-center text-muted' ), class: 'tr-no-record')
  end

  def partial_exist?(partial_name, prefixes = lookup_context.prefixes)
    lookup_context.exists?(partial_name, prefixes, true)
  end

end
