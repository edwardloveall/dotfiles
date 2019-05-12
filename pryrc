File.exist?('.debug.rb') && load('.debug.rb')

class Object
  def interesting_methods
    (methods - Object.new.methods).sort
  end
end

require 'logger'

if Object.const_defined? 'Rails'
  Rails.logger = Logger.new STDOUT
end
# print SQL to STDOUT
if Object.const_defined? 'ActiveRecord'
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Base.clear_reloadable_connections!
end
