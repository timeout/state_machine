require 'state_machine/transition'
require 'state_machine/state'

RSpec.describe 'StateMachine::Machine Machine' do
  describe '#add_transition' do
    it 'has no transitions on construction' do
      sm = StateMachine::Machine.new
      expect(sm.number_of_transitions).to eq(0)
    end

    it 'has a single tradition' do
      sm = StateMachine::Machine.new
      first_trans = StateMachine::Transition.new(nil, :first_event, :first)
      sm.add_transition(first_trans)
      expect(sm.number_of_transitions).to eq(1)
    end
  end

  describe '#show transitions' do
    it 'shows a single transition for first state' do
      sm = StateMachine::Machine.new
      first_trans = StateMachine::Transition.new(:start, :first_event, :first)
      sm.add_transition(first_trans)
      expect(sm.show_transitions_for(:start)).to eq("on first_event: start -> first")
    end
  end

  describe '#machine_state' do
    it 'returns the current machine_state of the machine' do
      sm = StateMachine::Machine.new
      expect(sm.machine_state).to eq(:start_state)
    end
  end

  describe '#transition' do
    it 'changes machine_state from nil to first on event first_event' do
      first_trans = StateMachine::Transition.new(:start_state, :first_event, :first)
      sm = StateMachine::Machine.new
      sm.add_transition first_trans
      sm.transition(:first_event)
      expect(sm.machine_state).to eq(:first)
    end

    it 'changes machine_state from first to second on event second_event' do
      first_trans = StateMachine::Transition.new(:start_state, :first_event, :first)
      second_trans = StateMachine::Transition.new(:first, :second_event, :second)
      sm = StateMachine::Machine.new
      sm.add_transition(first_trans)
      sm.add_transition(second_trans)
      sm.transition(:first_event)
      sm.transition(:second_event)
      expect(sm.machine_state).to eq(:second)
    end

    it 'changes machine_state from first to first on event first_event' do
      sm = StateMachine::Machine.new do |machine|
        machine.transitions << StateMachine::Transition.new(:start_state, :first_event, :first)
        machine.transitions << StateMachine::Transition.new(:first, :first_event, :first)
      end
      sm.transition(:first_event)
      sm.transition(:first_event)
      expect(sm.machine_state).to eq(:first)
    end

    it 'changes machine_state from second to first on event first_event' do
      sm = StateMachine::Machine.new do |machine|
        machine.transitions << StateMachine::Transition.new(:start_state, :first_event, :first)
        machine.transitions << StateMachine::Transition.new(:first, :second_event, :second)
        machine.transitions << StateMachine::Transition.new(:second, :first_event, :first)
      end
      sm.transition(:first_event)
      sm.transition(:second_event)
      sm.transition(:first_event)
      expect(sm.machine_state).to eq(:first)
    end

    it 'changes machine_state from first to third on event third_event', broken: true do
      sm = StateMachine::Machine.new do |machine|
        machine.transitions << StateMachine::Transition.new(:start_state, :first_event, :first)
        machine.transitions << StateMachine::Transition.new(:first, :third_event, :third)
      end
      sm.transition(:first_event)
      sm.transition(:third_event)
      expect(sm.machine_state).to eq(:third)
    end

    it 'throws an exception on an undefined event' do
      sm = StateMachine::Machine.new do |machine|
        machine.transitions << StateMachine::Transition.new(:start_state, :first_event, :first)
        machine.transitions << StateMachine::Transition.new(:first, :third_event, :third)
      end
      sm.transition(:first_event)
      expect{sm.transition(:bad_event)}.to raise_error
    end
  end
end
