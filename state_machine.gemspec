require 'date'
require File.join(File.dirname(__FILE__), 'lib/state_machine/version')

Gem::Specification.new do |s|
  s.name          = 'state_machine'
  s.version       = ::StateMachine::VERSION
  s.date          = Date.today.to_s
  s.summary       = "A simple state machine"
  s.description   = "A simple stae machine"
  s.authors       = ['Joe Gain']
  s.email         = 'joe.gain@gmail.com'
  s.files         = Dir["lib/**/*.rb"] + ['LICENSE']
  s.homepage      = 'https://github.com/timeout/state_machine'
  s.licenses      = ['BSD']
  s.has_rdoc      = false
end
