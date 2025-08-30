module Sources
  WEST_SEATTLE = 1
  VASHON       = 2
  
  class UnknownSource < StandardError; end
  
  class FormatChanged < StandardError; end

end