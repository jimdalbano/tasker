require 'rake/testtask'

Rake::TestTask.new() do |t|
  t.libs << "spec"
  t.pattern = "spec/**/*_spec.rb"
end



STATS_DIRECTORIES = [
  %w(Controllers        app/controllers),
  %w(Helpers            app/helpers),
  %w(Models             app/models),
  %w(Mailers            app/mailers),
  %w(Javascripts        app/assets/javascripts),
  %w(Libraries          lib/),
  %w(APIs               app/apis),
  %w(Controller\ tests  spec/controllers),
  %w(Helper\ tests      spec/helpers),
  %w(Model\ tests       spec/models),
  %w(Mailer\ tests      spec/mailers),
  %w(Integration\ tests spec/integration),
  %w(Functional\ tests\ (old)  spec/functional),
  %w(Unit\ tests \ (old)       spec/unit)
].collect { |name, dir| [ name, "#{Rails.root}/#{dir}" ] }.select { |name, dir| File.directory?(dir) }

desc "Report code statistics (KLOCs, etc) from the application"
task :stats_spec do
  require 'rails/code_statistics'
  CodeStatistics.new(*STATS_DIRECTORIES).to_s
end
