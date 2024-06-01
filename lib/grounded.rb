# frozen_string_literal: true

require "aggregate_root"
require "active_support/notifications"
require "arkency/command_bus"
require "dry-struct"
require "dry-types"
require "ruby_event_store"

require_relative "grounded/aggregate_root"
require_relative "grounded/command"
require_relative "grounded/command_bus"
require_relative "grounded/event_handler"
require_relative "grounded/event_store"
require_relative "grounded/event"
require_relative "grounded/process"
require_relative "grounded/testing"
require_relative "grounded/types"
require_relative "grounded/version"

module Grounded
  class Error < StandardError; end
end
