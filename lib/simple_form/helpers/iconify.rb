module SimpleForm #:nodoc:
  module Helpers #:nodoc:
    # Helpers to prefix material icon before inputs
    module Iconify
      private

      # Adds a supplied icon in front of the input
      def iconify
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
        icon = input_html_options.delete(:icon)
        out = ""
        out << "<i class='material-icons prefix'>#{icon}</i>".html_safe

        out << yield
        out
      end
    end
  end
end
