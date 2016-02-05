# CollectionSelectInput overrides input method on original class to add Materialize styling
class CollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput

  # Generates the HTML output for the input
  #
  # @param wrapper_options [Hash] options for the wrapper
  # @return [String] HTML markup of the input
  def input(wrapper_options)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    prompt = input_options.delete(:prompt)

    select = @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, merged_input_options
    )

    material_select = Nokogiri::HTML(select).css('select')
    material_prompt = "<option value='' disabled selected>#{prompt}</option>"

    material_select.children.first.add_next_sibling(material_prompt)
    material_select.children.first.remove
    material_select
  end
end
