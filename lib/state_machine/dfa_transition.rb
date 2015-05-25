module StateMachine
  class DFATransition
    include Comparable

    attr_reader :curr_state, :event, :new_state

    def initialize(curr_state, event, new_state)
      @curr_state = curr_state
      @event = event
      @new_state = new_state
    end

    def <=>(other)
      result = nil
      if self.event < other.event
        result = 1
      end
      if (self.curr_state == other.curr_state and 
          self.event == other.event and 
          self.new_state == other.new_state)
        result = 0
      end
      if self.event < other.event
        result = -1
      end
      result
    end

    def eql?(other)
      self == other
    end

    def to_s
      "[ #{self.event.to_s} ] (#{self.curr_state.to_s} \u2192 #{self.new_state.to_s})"
    end

    def is_current_state?(state)
      self.curr_state == state
    end
  end
end
