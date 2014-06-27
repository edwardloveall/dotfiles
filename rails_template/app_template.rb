ruby_comment = /^(\s)*#.*\n/

# Modify the database config
gsub_file 'config/database.yml', /username\: .+/, "username: <% ENV['POSTGRES_USERNAME'] %>"
gsub_file 'config/database.yml', ruby_comment, ''

# Clear Routes
gsub_file 'config/routes.rb', ruby_comment, ''

# Clear Gemfile
remove_file 'Gemfile'

# Remove Assets
remove_file 'app/assets/javascripts/application.js'
remove_file 'app/assets/stylesheets/application.css'

# Add Custom Files
template_dir = "#{File.dirname(__FILE__)}/template"
files = []

inside template_dir do
  files = Dir.glob("**/*.*")
  files << 'Gemfile'
  files << 'Guardfile'
end

files.each do |file|
  copy_file [template_dir, file].join('/'), file
end

append_to_file '.gitignore', '/coverage'

# Create database
run 'rake db:create'

# Git Repo
git :init
git add: '.'
git commit: '-m "Initial commit."'
