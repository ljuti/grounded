# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Event handler" do
  TestPlumbing.with(
    event_store: Grounded::EventStore.in_memory,
    command_bus: Grounded::CommandBus
  ) do |event_store|
    it "handles the event" do
      event_store.subscribe(DoThis, to: [SomethingHappened])
      event = SomethingHappened.new(data: { what: "happened" })

      event_store.publish(event)

      expect { DoThis.drain }.not_to raise_error
    end

    class DoThis < Grounded::EventHandler
      def call(event)
      end
    end

    class SomethingHappened < Grounded::Event
    end
  end
end