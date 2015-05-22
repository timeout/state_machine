require 'state_machine/transition'

RSpec.describe 'StateMachine::Transitions' do
  describe 'defines a transition' do
    it 'defines a transition from first to second on event second_event' do
      transition = StateMachine::Transition.new(:first, :second_event, :second)
      expect(transition.to_s).to eq("on second_event: first -> second")
    end
  end

  describe '#is_current_state?' do
    it 'returns true if curr_state is state' do
      transition = StateMachine::Transition.new(:first, :second_event, :second)
      expect(transition.is_current_state?(:first)).to be_truthy
    end
  end
end

