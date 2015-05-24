require 'state_machine/pda_transition'
require 'state_machine/stack'

module StateMachine
  class PDA

    attr_reader :stack, :state, :transitions, :start_state

    def initialize(start_state = :start_state, transitions = Array.new)
      @state = @start_state = start_state
      @stack = Stack.new
      @stack.push( start_state )
      @transitions = transitions
      yield(self) if block_given?
    end

    def machine_state
      @state
    end

    def number_of_transitions
      return transitions.size
    end

    def add_transition(transition)
      transitions << transition
    end

    def transitions_for(state)
      @transitions.find_all { |trans| trans.is_current_state? state }
    end

    def show_transitions_for(state)
      search = transitions_for(state)
      search.map { |trans| trans.to_s }.join('\n')
    end

    def transition(on_event, on_op)

      # are there any tansitions for the current state on this event?
      transitions = transitions_for(@state)

      if transitions.empty?
        raise IllegalState
          .new( "PDA state: [ #{@state} ] (Unknown transition: [ #{on_event} ])" )
      end

      events = transitions.find_all do |trans| 
        trans.event == on_event and trans.stack_op == on_op
      end

      unless events.size == 1
        raise IllegalTransition
          .new( "DFA state: [ #{@state} ]" +
        " (Multiple transitions defined for [ #{on_event}:#{on_op} ]) " ) 
      end

      @stack.push(events.first.new_state) if on_op == :push
      @stack.pop if on_op == :pop

      @state = @stack.peek
    end

    def events
      @transitions.collect { |transition| transition.new_state }
    end

    private
    attr_writer :transitions

  end
end
