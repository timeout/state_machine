module StateMachine

  class Error < StandardError
  end

  class IllegalTransition < Error
  end

  class IllegalState < Error
  end

  class UnknownStackOp < Error
  end
end

require 'state_machine/dfa'
require 'state_machine/pda'
require 'state_machine/dfa_transition'
require 'state_machine/pda_transition'
require 'state_machine/stack'
