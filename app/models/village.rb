# frozen_string_literal: true

# == Schema Information
#
# Table name: villages
#
#  id           :bigint           not null, primary key
#  description  :text
#  disabled     :boolean          default(FALSE)
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  extension_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_villages_on_extension_id  (extension_id)
#  index_villages_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (user_id => users.id)
#
class Village < ApplicationRecord
  include Scopes::Village
  include Delegates::Village
  include Relations::Village
  include Validations::Village
end
