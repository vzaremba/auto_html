require 'uri'
require 'rinku'
require 'rexml/document'

AutoHtml.add_filter(:link).with({}) do |text, options|
  option_short_link_name = options.delete(:short_link_name)
  attributes = Array(options).reject { |k,v| v.nil? }.map { |k, v| %{#{k}="#{REXML::Text::normalize(v)}"} }.join(' ')
  Rinku.auto_link(text, :all, attributes) do |url|
    if option_short_link_name
      uri = URI(url)
      uri.query = nil
      uri.to_s
    else
      url
    end
  end
end
