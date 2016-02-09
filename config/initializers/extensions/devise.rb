Devise::FailureApp.module_eval do

  def scope_url
    opts  = {}
    route = route(scope)
    opts[:format] = request_format unless skip_format?

    config = Rails.application.config

    # Patch that monkey
    #
    # https://github.com/plataformatec/devise/issues/3801
    #
    # # Rails 4.2 goes into an infinite loop if opts[:script_name] is unset
    # if (Rails::VERSION::MAJOR >= 4) && (Rails::VERSION::MINOR >= 2)
    #   opts[:script_name] = (config.relative_url_root if config.respond_to?(:relative_url_root))
    # else
    #   if config.respond_to?(:relative_url_root) && config.relative_url_root.present?
    #     opts[:script_name] = config.relative_url_root
    #   end
    # end

    if config.respond_to?(:relative_url_root) && config.relative_url_root.present?
      opts[:script_name] = config.relative_url_root
    end

    #
    # End of patch

    router_name = Devise.mappings[scope].router_name || Devise.available_router_name
    context = send(router_name)

    if context.respond_to?(route)
      context.send(route, opts)
    elsif respond_to?(:root_url)
      root_url(opts)
    else
      "/"
    end
  end
end
