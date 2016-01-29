# IconNumberFieldInput prefixes a supplied icon before the password field
class IconNumberFieldInput < SimpleForm::Inputs::Base

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    icon = input_html_options.delete(:icon)
    out = ""
    out << "<i class='material-icons prefix'>#{icon}</i>".html_safe
    out << "#{@builder.number_field(attribute_name, merged_input_options)}".html_safe
    out
  end
end
