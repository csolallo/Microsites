String.class_eval do
  def to_schedule_key
    case self
    when 'Mon', 'Tue', 'Wed', 'Thu' 
      :m2t
    when 'Fri'
      :fri
    when 'Sat'
      :sat
    when 'Sun'
      :sun
    else
      nil
    end
  end

  def proper_case
    self.split(' ').map(&:capitalize).join (' ')
  end
end
