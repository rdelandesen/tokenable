require 'spec_helper'

RSpec.describe User do
  before do
    @user = User.new
    @user.tokenable.generate
  end

  context 'when valid' do
    it 'has a token' do
      expect(@user.token).to_not be_nil
    end
  end
end