class BigDecimal
  def as_json(_options = nil)
    to_f.round(2)
  end
end
