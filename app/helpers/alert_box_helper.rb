module AlertBoxHelper
  include ActionView::Helpers

  def alert_box(content_or_options=nil, options={}, &block)
    content_or_options.is_a?(Hash) ? options = content_or_options : content = content_or_options

    dismissible = options.delete(:dismissible).present?
    klass       = options.delete(:class)
    type        = case options.delete(:type)
                    when 'info', :info
                      'alert-info'
                    when 'success', :success
                      'alert-success'
                    when 'warning', :warning
                      'alert-warning'
                    when 'danger', :danger
                      'alert-danger'
                    else
                      'alert-info'
                  end

    options.merge!({class: "alert #{type} #{klass}".squeeze(' ').strip, role: 'alert'})

    content_tag :div, options do
      if dismissible
        ("<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'" +
          '>&times;</span></button>' + (content.presence || capture(&block))).html_safe
      else
        content.presence || capture(&block)
      end
    end
  end

end