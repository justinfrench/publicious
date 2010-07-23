Gem::Specification.new do |s|
  s.name = %q{publicious}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin French", "Daniel Neighman"]
  s.date = %q{2010-07-22}
  s.description = %q{A Rails 3 gem plugin for plugins to serve images, javascripts and stylesheets from thier own public directory}
  s.summary = %q{A Rails gem plugin for plugins to serve images, javascripts and stylesheets from thier own public directory}
  s.email = %q{justin@indent.com.au}
  s.homepage = %q{http://github.com/justinfrench/publicious}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = Dir["**/*"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
