require 'define_columns/table_column'
require 'define_columns/table_columns'

module DefineColumns

  def self.included(klass)
    klass.class_eval do
      extend DefineColumns::ClassMethods
    end
  end

  module ClassMethods

    def table_columns
      @table_cols.columns
    end

    def define_columns
      @table_cols = TableColumns.new(self.content_columns.map(&:name))
      yield @table_cols
    end

  end

end

ActiveRecord::Base.class_eval { include DefineColumns }
