require_relative '../bin/utils'

module Jekyll
  module StringUtils
    def propercase(input)
      if input.is_a?(String)
        input.proper_case
      else
        input
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringUtils)