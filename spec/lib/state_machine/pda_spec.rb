require 'state_machine'
require 'state_machine/pda'
require 'state_machine/pda_transition'

RSpec.describe 'StateMachine::PDA' do
  describe '#add_transition' do
    it 'has no transitions on construction' do
      pda = StateMachine::PDA.new
      expect(pda.number_of_transitions).to eq(0)
    end

    it 'has a single tradition' do
      pda = StateMachine::PDA.new
      first_trans = StateMachine::PDATransition
        .new(:start_state, :first_event, :push, :first_state)
      pda.add_transition(first_trans)
      expect(pda.number_of_transitions).to eq(1)
    end
  end

  describe '#machine_state' do
    it 'returns the start_state of the machine on initialization' do
      pda = StateMachine::PDA.new
      expect(pda.machine_state).to eq(:start_state)
    end

    it 'returns first_state' do
      pda = StateMachine::PDA.new do |machine|
        machine.transitions << StateMachine::PDATransition
            .new(:start_state, :first_event, :sleep)
      end
      expect(pda.transition(:first_event, :sleep)).to eq(:start_state)
    end

    it 'returns the start_state' do
      pda = StateMachine::PDA.new do |machine|
        machine.transitions << StateMachine::PDATransition
            .new(:start_state, :first_event, :push, :first_state)
        machine.transitions << StateMachine::PDATransition
            .new(:first_state, :first_event, :pop)
      end
      pda.transition(:first_event, :push)
      expect(pda.transition(:first_event, :pop)).to eq(:start_state)
    end

    it 'returns the start_state' do
      pda = StateMachine::PDA.new do |machine|
        machine.transitions << StateMachine::PDATransition
            .new(:start_state, :first_event, :push, :first_state)
        machine.transitions << StateMachine::PDATransition
            .new(:first_state, :first_event, :push, :first_state)
        machine.transitions << StateMachine::PDATransition
            .new(:first_state, :first_event, :pop)
      end
      pda.transition(:first_event, :push)   # first_state
      expect(pda.state).to eq(:first_state)
      pda.transition(:first_event, :push)   # first_state | first_state
      pda.transition(:first_event, :push)   # first_state | first_state | first_state
      pda.transition(:first_event, :pop)    # first_state | first_state
      pda.transition(:first_event, :pop)    # first_state |
      expect(pda.state).to eq(:first_state)
      pda.transition(:first_event, :pop)    #
      expect(pda.state).to eq(:start_state)
    end

    it 'returns to the article_state' do
      pda = StateMachine::PDA.new do |machine|
        machine.transitions << StateMachine::PDATransition
            .new(:start_state, :article, :push, :article_state)
        machine.transitions << StateMachine::PDATransition
            .new(:article_state, :article, :pop)
        machine.transitions << StateMachine::PDATransition
            .new(:article_state, :body, :push, :body_state)
        machine.transitions << StateMachine::PDATransition
            .new(:body_state, :body, :push, :body_state)
        machine.transitions << StateMachine::PDATransition
            .new(:body_state, :body, :pop)
        machine.transitions << StateMachine::PDATransition
            .new(:body_state, :article, :pop)
      end
      pda.transition(:article, :push)
      expect(pda.state).to eq(:article_state)
      pda.transition(:body, :push)
      expect(pda.state).to eq(:body_state)
      pda.transition(:body, :push)
      expect(pda.state).to eq(:body_state)
      pda.transition(:body, :pop)
      expect(pda.state).to eq(:body_state)
      pda.transition(:body, :pop)
      expect(pda.state).to eq(:article_state)
      pda.transition(:article, :pop)
      expect(pda.state).to eq(:start_state)
    end
  end
end
