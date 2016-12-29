module Integral
  # Allow list items to be renderered through a partial
  class PartialListItemRenderer < Integral::ListItemRenderer

    def initialize(list_item, opts={})
      super

      raise ArgumentError.new("PartialListItemRenderer requires the view context (pass this in via opts hash)") if @opts[:context].blank?
      raise ArgumentError.new("PartialListItemRenderer requires the partial_path (pass this in via opts hash)") if @opts[:partial_path].blank?
    end

    # Override Integral::ListItemRenderer#render_item
    def render_item
      partial_opts = {
        title: title,
        subtitle: subtitle,
        description: description,
        url: url,
        image: image
      }

      opts[:context].render_to_string partial: @opts[:partial_path], locals: partial_opts, layout: false
    end
  end
end
