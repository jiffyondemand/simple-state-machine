$:.push File.expand_path("../lib", __FILE__)
require "ssm/version"

Gem::Specification.new do |s|
  s.name = "ssm"
  s.version = SSM::VERSION
  s.authors = ["Michael Choi", "Si Le"]
  s.homepage = %q{https://github.com/jiffyondemand/ssm}

  s.summary = %q{Simple State Machine for Ruby/Ruby on Rails}
  s.description = %q{SSM is a simplier, more manually configurable implementation of a state machine}

  s.date = Time.now
  s.licenses = ["MIT"]

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
