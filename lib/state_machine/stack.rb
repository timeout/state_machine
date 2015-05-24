module StateMachine
  class Stack
    include Enumerable

    def initialize
      @data = Array.new
    end

    def push(element)
      @data << element
    end

    def pop
      raise EmptyStack.new('Illegal pop operation on empty stack') if @data.empty?
      @data.pop
    end

    def peek
      @data.last
    end

    def size
      @data.size
    end

    def each
      @data.each { |d| yield(d) }
    end
  end
end
