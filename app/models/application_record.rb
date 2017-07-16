class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @@connection = ActiveRecord::Base.connection()

  def self.connection
    @@connection
  end
end
