# frozen_string_literal: true

require "aggregate_root"
require "active_support/notifications"

module Grounded
  class AggregateRootRepository
    def initialize(event_store, notifications = ActiveSupport::Notifications)
      @repository = AggregateRootRepository::InstrumentedRepository.new(
        AggregateRootRepository::Repository.new(event_store),
        notifications
      )
    end

    def with_aggregate(aggregate_class, aggregate_id, &block)
      @repository.with_aggregate(
        aggregate_class.new(aggregate_id),
        stream_name(aggregate_class, aggregate_id),
        &block
      )
    end

    def stream_name(aggregate_class, aggregate_id)
      "#{aggregate_class.name}$#{aggregate_id}"
    end
  end
end
