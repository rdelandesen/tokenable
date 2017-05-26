require 'spec_helper'

RSpec.describe Tokenable::Configuration do

  METHODS = %w(urlsafe_base64 base64 hex random_bytes random_number uuid)

  before do
    @n      = 12..43
    @attrs  = %i(token secure_id)
    @meth0d = :base64
    @prefix = :my_prefix

    @configuration = Tokenable::Configuration.new(User)

    @configuration.n      = @n
    @configuration.attrs  = @attrs
    @configuration.meth0d = @meth0d
    @configuration.prefix = @prefix
  end

  context 'when valid' do
    it 'has good values' do
      expect(@configuration.n).to      be_a(Range)
      expect(@configuration.attrs).to  eq(@attrs)
      expect(@configuration.meth0d).to eq([@meth0d.to_s])
      expect(@configuration.prefix).to eq(@prefix)
    end

    it 'accepts single attr' do
      expect { @configuration.attr = 'secure_id' }.to_not raise_error
      expect(@configuration.attrs).to eq(['secure_id'])
    end

    it 'accepts single attr on attrs' do
      expect { @configuration.attrs = 'token' }.to_not raise_error
      expect(@configuration.attrs).to eq(['token'])
    end

    it 'accepts Fixnum length' do
      expect { @configuration.n = 20 }.to_not raise_error
      expect(@configuration.n).to be_a(Fixnum)
    end

    it 'accepts defined methods' do
      METHODS.each do |m|
        expect { @configuration.meth0d = m }.to_not raise_error
      end
    end
  end

  context 'when not valid' do
    it 'raises exception with bad length' do
      bad = [ 1.5, 'a', :a, Class.new ]

      bad.each do |v|
        expect { @configuration.n = v }.to raise_error(ArgumentError)
      end
    end

    it 'raises exception with bad meth0d' do
      expect { @configuration.meth0d = 'nop' }.to raise_error(ArgumentError)
    end
  end

end