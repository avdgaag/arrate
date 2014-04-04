module Arrate
  module Helpers
    module TitleHelper
      # Set or retrieve the current page title.
      #
      # To set a page title, call the method with an argument to use as page title.
      # To show the page title, call the method without any arguments.
      #
      # When a value for `title` has been set, this will use the
      # `title_placeholder` configuration key as format string to display the
      # title. If not, the `title_default` key is used.
      #
      # Note that the valeu of the title is always returned as a string in an HTML
      # tag. You can customise which tag with a `:tag` option. By default, when
      # assigngin a new title a `h1` tag will be used; when just reading the title
      # a `title` tag will be used. Any additional options will be passed to
      # `content_tag`.
      #
      # @example Set a page title
      #   title('foo') # => "<h1>foo</h1>"
      # @example Set a page title with interpolation
      #   title('Record %d', record.id) # => "<h1>Record 3</h1>"
      # @example Customise tag
      #   title('Record %d', record.id, tag: 'h2', class: 'title')
      #   # => "<h2 class="title">Record 3</h2>"
      # @example Read page title
      #   title # => "<title>Page title | including template</title>"
      # @example Read page title with custom tag
      #   title tag: 'div' # => "<div>Page title | including template</div>"
      #
      # @param [String] new_title
      # @return [String]
      def title(*args)
        options = args.extract_options!
        content_tag(
          options.fetch(:tag) { args.any? ? :h1 : :title },
          args.any? ? set_title(*args) : display_title,
          options.except(:tag)
        )
      end

      private

      def set_title(*args)
        format(*args).tap do |str|
          content_for :title, str
        end
      end

      def display_title
        if content_for?(:title)
          I18n.translate(
            :"title.#{controller_name}.#{action_name}.format",
            page_title: content_for(:title),
            default: [
              :"title.#{controller_name}.format",
              :"title.format",
              :"title.#{controller_name}.#{action_name}.default",
              :"title.#{controller_name}.default",
              :"title.default",
              Rails.application.class.parent_name
            ]
          )
        else
          I18n.translate(
            :"title.#{controller_name}.#{action_name}.default",
            default: [
              :"title.#{controller_name}.default",
              :"title.default",
              Rails.application.class.parent_name
            ]
          )
        end
      end
    end
  end
end
