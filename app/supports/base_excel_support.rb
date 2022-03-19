# frozen_string_literal: true

class BaseExcelSupport
  attr_reader :lists

  def initialize(lists)
    @lists = lists
  end

  def run
    renderer = ::Documents::Excel::ExcelRenderer.new(headers, data, 'Excel')
    renderer.run
  end
end
