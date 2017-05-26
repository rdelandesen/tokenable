require 'tokenable/active_record/instance_methods'
require 'tokenable/base'

module Tokenable
  module ActiveRecord
    module BaseMethods
      def tokenable
        include InstanceMethods
        @base ||= Tokenable::Base.new(self)
      end
    end
  end
end