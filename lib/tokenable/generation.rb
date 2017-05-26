module Tokenable
  class Generation

    def initialize(configuration)
      @configuration = configuration
    end

    def token
      setup
      "#{@configuration.prefix}#{SecureRandom.send(*@args)}"
    end

    private

    def setup
      setup_meth0d
      setup_length
      setup_args
    end

    def setup_meth0d
      @meth0d = @configuration.meth0d.sample
    end

    def setup_length
      @length = @configuration.n

      if %w(urlsafe_base64 base64).include?(@meth0d)
        @length = ((@length.is_a?(Range) ? Random.new.rand(@length) : @length) / 4.0 * 3).to_i
      end
    end

    def setup_args
      @args = [ @meth0d, @length ]

      @args.slice!(-1) if @meth0d == 'uuid'
    end

  end
end