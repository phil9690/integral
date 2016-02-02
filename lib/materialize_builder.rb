# Materialize builder for breadcrumbs
# :nocov:
class MaterializeBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder

  # @return [String] representing the breadcrumb
  def render
    output = ''
    output += "<nav class='breadcrumb_nav'>"
    output += "<div class='nav-wrapper'>"
    output += "<div class='col s12'>"
    #<a href="#!" class="breadcrumb">First</a>

    output += @elements.collect do |element|
      render_element(element)
    end.join

    output += "</div>"
    output += "</div>"
    output += "</nav>"

    output
  end

  private

  def render_element(element)
    if element.path == nil || @context.current_page?(compute_path(element))
      @context.content_tag('span', compute_name(element), class: :breadcrumb)
    else
      @context.link_to(compute_name(element), compute_path(element), element.options.merge!(class: :breadcrumb))
    end
  end
end

