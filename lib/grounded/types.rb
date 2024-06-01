# frozen_string_literal: true

module Grounded
  module Types
    include Dry.Types()

    UUID =
      Types::Strict::String.constrained(
        format: /\A[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}\z/i
      )

    ULID =
      Types::Strict::String.constrained(
        format: /\A[0-9A-HJ-NP-Y]{26}\z/
      )

    ID = Types::Strict::Integer

    Metadata =
      Types::Hash.schema(
        timestamp: Types::Time.meta(omittable: true)
      )

    EmailAddress =
      Types::Strict::String.constrained(
        format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      )
  end
end
