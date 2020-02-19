class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.errors?
    errors.any?
  end

  def self.validates_uniqueness(*attr_names)
    configuration = { attribute_name: :name, scope: nil, message: I18n.t('errors.messages.taken') }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names) do |record, record_attr_name, value|
      duplicates = Set.new
      attr_name = configuration[:attribute_name]
      scope = configuration[:scope]

      value.map do |obj|
        ob = {}
        ob[attr_name] = obj.try(attr_name)
        ob[scope] = obj.try(scope)
        if duplicates.member?(ob)
          record.errors.add(record_attr_name, "#{attr_name} #{configuration[:message]}")
        else
          duplicates.add(ob)
        end
      end
    end
  end
end
