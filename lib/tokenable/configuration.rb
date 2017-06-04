module Tokenable
  ##
  # = Tokenable/Configuration
  #
  class Configuration
    attr_accessor :attr, :attrs, :n, :prefix, :meth0d, :callback, :model

    METHODS = %w(urlsafe_base64 base64 hex random_bytes random_number uuid).freeze

    def initialize(model)
      @n        = 32
      @attrs    = :token
      @meth0d   = :urlsafe_base64

      @model = model

      self.callback = :before_create
    end

    def attr=(value)
      self.attrs = value
    end

    def attrs=(value)
      @attrs = value.is_a?(Array) ? value : [value]
    end

    def n=(value)
      unless value.is_a?(Range) || value.is_a?(Fixnum)
        raise ArgumentError.new('Length needs to be a Range or a Fixnum')
      end

      @n = value
    end

    def meth0d=(value)
      values = value.is_a?(Array) ? value : [value]
      values.map! { |v| v.to_s }

      raise ArgumentError.new('Method is not supported') if (values - METHODS).size > 0
      @meth0d = values
    end

    def callback=(value)
      @callback = value
      eval_callback
      @callback
    end

    private

    def eval_callback
      @model.class_eval("#{@callback} :generate_tokenable")
    end
  end
end