class BigDecimal
  def as_json(_options = nil)
    to_f
  end
end