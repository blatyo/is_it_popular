require File.expand_path('../config/application', __FILE__)
require 'rake'

module ::IsItPopular
  class Application
    include Rake::DSL
  end
end

module ::RakeFileUtils
  extend Rake::FileUtilsExt
end

IsItPopular::Application.load_tasks
