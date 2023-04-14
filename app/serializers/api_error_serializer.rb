class APIErrorSerializer
  attr_reader :error

  def initialize(error)
    @error = error
  end

  def serializable_hash
    error.serializable_hash
  end

  def to_json(_options = {})
    serializable_hash.to_json
  end
end
