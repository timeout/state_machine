require 'state_machine/transition'

module StateMachine
  class Machine

    attr_reader :transitions, :start_state

    def initialize(start_state = :start_state, transitions = [])
      @state = @start_state = :start_state
      @transitions = transitions
      yield(self) if block_given?
    end

    def machine_state
      @state
    end

    def ==(other)
      @start_state == other.start_state and transitions == other.transitions
    end

    def eql?(other)
      self == other
    end

    def add_transition(transition)
      @transitions << transition
    end

    def transitions_for(state)
      @transitions.find_all { |trans| trans.is_current_state? state }
    end

    def show_transitions_for(state)
      search = transitions_for(state)
      search.map { |trans| trans }.join('\n')
    end

    def transition(on_event)

      # are there any tansitions for the current state on this event?
      transitions = transitions_for(@state)
      if transitions.empty?
        raise IllegalState.new( "Machine state: [ #{@state} ] (Unknown transition: [ #{on_event} ])" )
      end

      # is there more than one transition for the current state on this
      # event?
      events = transitions.find_all { |trans| trans.event == on_event }
      unless events.size == 1
        raise IllegalTransition.new( "Machine state: [ #{@state} ] (Multiple transitions defined for [ #{on_event} ]) " ) 
      end

      @state = events.first.new_state
    end

    def number_of_transitions
      @transitions.size
    end

    private
      attr_writer :transitions
  end
end
