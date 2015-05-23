module StateMachine

  class Error < StandardError
  end

  class IllegalTransition < Error
  end

  class IllegalState < Error
  end

end

require 'state_machine/state'
require 'state_machine/transition'
