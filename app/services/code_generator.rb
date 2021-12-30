# frozen_string_literal: true

class CodeGenerator < BaseService
  def generate
    fetch_code
  end

  private

  def fetch_code
    initial_code
  end

  def initial_code
    "R#{current_date}"
  end

  def current_date
    Time.current.strftime('%y%m%d%H%M%S%2N')
  end
end
