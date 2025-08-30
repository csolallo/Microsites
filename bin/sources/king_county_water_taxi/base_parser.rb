  class BaseParser
    
    protected

    def validate_columns(container, expected_column_names)
      headers = []
      col_headers = container.css('thead tr th')
      col_headers.each { |h| headers << h.text.chomp }
    
      raise Sources::FormatChanged unless headers == expected_column_names
    end
  end