File.exist?('.debug.rb') && load('.debug.rb')

Pry.config.should_load_plugins = false
Pry.plugins['rails'].disable!
Pry.plugins['stack_explorer'].disable!
