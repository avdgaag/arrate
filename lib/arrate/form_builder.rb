require 'simple_form'

module Arrate
  class FormBuilder < SimpleForm::FormBuilder
    def base_errors
      return unless object.errors[:base].any?
      template.content_tag :ol, class: 'base-errors' do
        object.errors[:base].each_with_object('') do |msg, output|
          output << template.content_tag(:li, msg)
        end.html_safe
      end
    end

    def submit_or_cancel(options = {})
      button_label      = options.fetch(:button_label, [])
      separator         = options.fetch(:separator, 'or')
      separator_tag     = options.fetch(:separator_tag, :span)
      link_label        = options.fetch(:link_label, 'cancel')
      link_url_options  = options.fetch(:url, :back)
      link_html_options = options.fetch(:url, rel: 'back', class: 'submit-or-cancel-cancel')
      button_button(*button_label) +
        ' ' +
        template.content_tag(separator_tag, separator, class: 'submit-or-cancel-separator') +
        ' ' +
        template.link_to(link_label, link_url_options, link_html_options)
    end
  end
end
