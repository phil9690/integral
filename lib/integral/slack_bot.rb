module Integral
  # Interacts with Slack web hook
  class SlackBot

    # @param opts [Hash] web hook options
    def self.ping(opts)
      return if Integral.configuration.slack_web_hook_url.blank?

      slackbot = SlackBot.new(Integral.configuration.slack_web_hook_url)
      slackbot.ping(opts)
    end

    # @param web_hook_url [String] Slack web hook URL to ping
    def initialize(web_hook_url)
      @bot = Slack::Notifier.new(web_hook_url)
    end

    # @param message_options [Hash] containing slack message options
    def ping(message_options)
      ping_opts = {}
      slack_message = message(message_options[:message])

      response = @bot.ping(slack_message.deep_stringify_keys, ping_opts)

      if response != '200'
        log_message = "Not able to ping slack: #{response.body}"
        Rails.logger.error log_message
      end
    end

    private

    def message(options)
      message = {
        attachments: [ {
          color: "#d31a5e"
        } ]
      }

      message[:attachments].first.merge!(options)
      message
    end
  end
end
