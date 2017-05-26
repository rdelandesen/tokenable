require 'tokenable/configuration'
require 'tokenable/generation'

module Tokenable
  class Base
    attr_reader   :configuration
    attr_accessor :model_instance

    def initialize(model)
      @model = model
      @configuration ||= Configuration.new(@model)
    end

    def config
      yield @configuration
    end

    def generate
      raise Exception.new('Model instance is missing') unless self.model_instance.present?

      generation = Generation.new(@configuration)

      @configuration.attrs.each do |attr|
        self.model_instance.send("#{attr}=", loop do
          t = generation.token
          break t unless @model.exists?(attr => t)
        end)
      end
    end
  end
end