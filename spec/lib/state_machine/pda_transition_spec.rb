require 'state_machine/pda_transition'

RSpec.describe 'StateMachine::PDATransition' do
  describe 'defines a transition' do 
    it 'from first_state to second_state \
            on event first_event with stack_operation push' do
      pda_transition = StateMachine::PDATransition
          .new(:first_state, :first_event, :push, :second_state)
      expect(pda_transition.to_s).to eq('event: first_event, ' +
          'stack operation: push, first_state -> second_state')
    end

    it 'UknownStackOp raised if the stack_op is unknown' do
      expect{StateMachine::PDATransition
        .new(:first_state, :first_event, :unknown, :second_state)}
        .to raise_error StateMachine::UnknownStackOp
    end

    it 'IllegalState raised if nil state pushed' do
      expect{StateMachine::PDATransition
        .new(:start_state, :first_event, :push)}
        .to raise_error StateMachine::IllegalState
    end

    it '#==(other)' do
      pda_transition = StateMachine::PDATransition
        .new(:first_state, :first_event, :push, :second_state)
      expect(pda_transition).to eq(StateMachine::PDATransition
        .new(:first_state, :first_event, :push, :second_state))
    end

  end
end
