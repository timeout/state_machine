module StateMachine
  class PDATransition

    attr_reader :curr_state, :event, :stack_op, :new_state

    STACK_OP = [:push, :pop, :sleep]

    def initialize(curr_state, event, stack_op, new_state = nil)
      raise UnknownStackOp
        .new("unknown stack operation: #{stack_op}") unless STACK_OP
        .include? stack_op
      raise IllegalState
        .new("illegal stack operation: can't push" +
      " 'nil' state onto stack") if (stack_op == :push and new_state.nil?)
      @curr_state = curr_state
      @event = event
      @stack_op = stack_op
      @new_state = new_state
    end

    def ==(other)
      @curr_state == other.curr_state and 
        @event == other.event and 
        @stack_op == other.stack_op and
        @new_state == other.new_state
    end

    def eql?(other)
      self == other
    end

    def to_s
      "event: #{@event}, stack operation: #{@stack_op}, #{@curr_state} -> #{@new_state}"
    end

    def is_current_state?(state)
      @curr_state == state
    end

  end
end
