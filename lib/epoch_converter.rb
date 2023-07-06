module EpochConverter
  def self.to_datetime(timestamp = nil)
    if timestamp
      timestamp = timestamp.to_i
      Time.at(timestamp).to_datetime
    end
  end
end
