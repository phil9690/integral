# FileInput creates materialize file input
class FileInput < SimpleForm::Inputs::Base

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    provided_button_label = merged_input_options[:button_label]
    # Possibly add check for presence of the i18n label
    button_label = provided_button_label.present? ? provided_button_label : I18n.t('simple_form.inputs.file.button_label')

    out = "<div class='btn'>"
    out << "<span>#{button_label}</span>"
    out << @builder.file_field(attribute_name, merged_input_options)
    out << "</div>"
    out << "<div class='file-path-wrapper'>"
    out << "<input class='file-path validate' type='text' value='#{object.send(attribute_name).try(:url)}'>"
    out << "</div>"
    out
  end
end
