require 'json'

module Jekyll
  class JsonConstTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      json = JSON.load_file("./_data/#{@text}.json")
      "const #{@text} = #{JSON.pretty_generate(json)}"
    end
  end
end

Liquid::Template.register_tag('json_const', Jekyll::JsonConstTag)