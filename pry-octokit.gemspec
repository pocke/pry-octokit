
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pry/octokit/version"

Gem::Specification.new do |spec|
  spec.name          = "pry-octokit"
  spec.version       = Pry::Octokit::VERSION
  spec.authors       = ["Masataka Pocke Kuwabara"]
  spec.email         = ["kuwabara@pocke.me"]

  spec.summary       = %q{pry ❤ octokit}
  spec.description   = %q{pry ❤ octokit}
  spec.homepage      = "https://github.com/pocke/pry-octokit"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "octokit"
end
