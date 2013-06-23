task :default => [:compile]

task :compile do

  require File.expand_path("gem/lib/angular-tabs/version")

  require "coffee-script"
  require "uglifier"

  script = CoffeeScript.compile collect_coffees

  prepend_author_notice(script)

  File.open("angular-tabs.js", "w") { |file| file.write(script) }
  File.open("gem/app/assets/javascripts/angular-tabs.js", "w") { |file| file.write(script) }
  File.open("angular-tabs.min.js", "w") { |file| file.write(prepend_author_notice(Uglifier.new.compile(script))) }

end

def collect_coffees
  files = ["angular-tabs"]
  script = ""
  files.each do |file|
    script << File.read("coffee/#{file}.coffee") << "\n"
  end
  script
end

def prepend_author_notice script
  comments = ""
  comments << "// author:   Samuel Mueller \n"
  comments << "// version:  #{AngularTabs::VERSION} \n"
  comments << "// license:  MIT \n"
  comments << "// homepage: http://github.com/ssmm/angular-tabs \n"

  script.prepend comments
  script
end