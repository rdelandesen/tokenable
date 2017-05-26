module Tokenable
  module ActiveRecord
    module InstanceMethods
      def tokenable
        self.class.tokenable.model_instance = self
        self.class.tokenable
      end

      def generate_tokenable
        tokenable.generate
      end
    end
  end
end