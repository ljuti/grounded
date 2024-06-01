# frozen_string_literal: true

module TestPlumbing
  def self.with(event_store:, command_bus:)
    Module.new do
      include TestMethods

      define_method :before_setup do
        @command_bus = command_bus.call
        @event_store = event_store.call
      end
    end
  end

  def self.included(klass)
    klass.include TestPlumbing.with(
      event_store: -> { EventStore.in_memory },
      command_bus: -> { CommandBus.new }
    )
  end

  module TestMethods
    attr_reader :event_store, :command_bus

    def arrange(*commands)
      commands.each { |command| act(command) }
    end

    def act(command)
      command_bus.call(command)
    end

    alias_method :run_command, :act

    def expect_events(stream_name, *expected_events)
      scope = event_store.read.stream(stream_name)
      before = scope.last
      yield
      actual_events = before.nil? ? scope.to_a : scope.from(before.event_id).to_a
      to_compare = ->(event) { {type: event.event_type, data: event.data} }
      expect(expected_events.map(&to_compare)).to eql(actual_events.map(&to_compare))
    end

    def expect_changes(actuals, expected)
      expects = expected.map(&:data)
      expect(expects).to eql(actuals.map(&:data))
    end
  end
end
