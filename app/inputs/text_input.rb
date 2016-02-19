# TextInput overrides input method on original class to add Materialize class
class TextInput < SimpleForm::Inputs::TextInput

  # @return [Array] list of html classes to be used when generating the input
  def input_html_classes
    super.push('materialize-textarea')
  end
end
