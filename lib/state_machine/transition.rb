module StateMachine
  class Transition

    attr_reader :curr_state, :event, :new_state

    def initialize(curr_state, event, new_state)
      @curr_state = curr_state
      @event = event
      @new_state = new_state
    end

    def ==(other)
      @curr_state == other.curr_state and @event == other.event and @new_state == other.new_state
    end

    def eql?(other)
      self == other
    end

    def to_s
      "on #{@event.to_s}: #{@curr_state.to_s} -> #{@new_state.to_s}"
    end

    def is_current_state?(state)
      curr_state == state
    end
  end
end
