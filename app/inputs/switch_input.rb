# SwitchInput creates a switch to toggle a true or false input
class SwitchInput < SimpleForm::Inputs::Base

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    out = ""
    out << "<div class='row switch'>".html_safe
    out << "<label>".html_safe
    out << I18n.t('simple_form.inputs.switch.turn_off').html_safe
    out << "#{@builder.check_box(attribute_name, input_html_options)}".html_safe
    out << "<span class='lever'></span>".html_safe
    out << I18n.t('simple_form.inputs.switch.turn_on').html_safe
    out << "</label>".html_safe
    out << "</div>".html_safe
    out
  end
end
