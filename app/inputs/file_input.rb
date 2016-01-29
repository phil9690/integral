# FileInput creates a switch to toggle a true or false input
class FileInput < SimpleForm::Inputs::Base

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    out = "<div class='btn'>"
    out << "<span>File</span>"
    out << @builder.file_field(attribute_name, merged_input_options)
    out << "</div>"
    out << "<div class='file-path-wrapper'>"
    out << "<input class='file-path validate' type='text'>"
    out << "</div>"
    out
  end
end
