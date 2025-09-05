module Sources
  WEST_SEATTLE = 1
  VASHON       = 2
  
  class UnknownSource < StandardError; end
  
  class FormatChanged < StandardError; end

  class NetworkError < StandardError; end
end