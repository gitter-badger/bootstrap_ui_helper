module ModalHelper
  include ActionView::Helpers

  def modal(options={}, &block)
    button_options = options.delete(:button) || {}

    caption               = button_options.delete(:caption) || 'Modal'
    modal_dialog_id       = options[:id] || "modal-#{rand(0...999)}"
    button_options[:data] = (button_options[:data] || {}).merge({toggle: 'modal', target: "##{modal_dialog_id}"})
    size                  = case options.delete(:size).try(:to_sym)
                              when :xsmall
                                'modal-sm'
                              when :large
                                'modal-lg'
                              else
                            end

    options[:class] = "modal fade #{options[:class]}"
    options.merge!({id: modal_dialog_id, tabindex: -1, role: 'dialog', aria: {hidden: true}})

    ((button caption, button_options) +
      (content_tag :div, options do
        content_tag :div, class: "modal-dialog #{size}" do
          content_tag :div, class: 'modal-content' do
            yield if block_given?
          end
        end
      end)).html_safe
  end

  def modal_header(content_or_options=nil, options={}, &block)
    content_or_options.is_a?(Hash) ? options = content_or_options : content = content_or_options

    tag = case options.delete(:size).try(:to_i)
            when 1
              'h6'
            when 2
              'h5'
            when 3
              'h4'
            when 4
              'h3'
            when 5
              'h2'
            when 6
              'h1'
            else
              'h4'
          end

    options[:class] = "modal-title #{options[:class]}"

    content_tag :div, class: 'modal-header' do
      ("<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>×</span></button>" +
        (content_tag tag, options do
          content.presence || capture(&block)
        end)).html_safe
    end
  end

  def modal_body(content_or_options=nil, options={}, &block)
    content_or_options.is_a?(Hash) ? options = content_or_options : content = content_or_options

    options[:class] = "modal-body #{options[:class]}"

    content_tag :div, options do
      content.presence || capture(&block)
    end
  end

  def modal_footer(content_or_options=nil, options={}, &block)
    content_or_options.is_a?(Hash) ? options = content_or_options : content = content_or_options

    options[:class] = "modal-footer #{options[:class]}"

    content_tag :div, options do
      content.presence || capture(&block)
    end
  end

end