module FormsHelper

  def submit_button(text="Save", opts = {})
    size = opts.delete(:size) || 'md'
    icon = opts.delete(:icon) || 'check'
    content_tag :button, opts.merge(type: :submit, class: "btn btn-#{size} btn-primary", data: { disable_with: disable_with_text(opts.delete(:feedback_text)) }) do
      fa_icon icon, text: text
    end
  end


  private
    def disable_with_text(feedback_text)
      feedback_text = 'Saving...' if feedback_text.blank?
      "<i class='fa fa-fw fa-spin fa-spinner'></i> #{feedback_text}".html_safe
    end

end
