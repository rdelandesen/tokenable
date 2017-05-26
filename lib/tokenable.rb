require 'tokenable/version'
require 'tokenable/active_record/base_methods'

##
# = Tokenable
#
# == Example
#   class User < ActiveRecord::Base
#     tokenable.config do |c|
#       c.attrs    = :token
#       c.n        = 20..42
#       c.meth0d   = :urlsafe_base64
#       c.callback = :before_create
#     end
#   end
#
module Tokenable
end

::ActiveRecord::Base.extend(Tokenable::ActiveRecord::BaseMethods)