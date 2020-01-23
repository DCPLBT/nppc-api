module Helpers
  module User
    extend ActiveSupport::Concern

    def login=(login)
      @login = login
    end

    def login
      @login || username || email || phone
    end
  end
end
