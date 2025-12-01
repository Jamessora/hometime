# frozen_string_literal: true

module Reservations
  class CreateReservation
    PARSERS = {
      format_1: Parsers::Format1,
      format_2: Parsers::Format2
    }.freeze

    def self.call(payload)
      new(payload).call
    end

    def initialize(payload)
      @payload = payload
    end

    def call
      format = PayloadIdentifier.call(@payload)
      parser = PARSERS[format]

      raise "Unsupported payload format: #{format}" if parser.nil?

      parsed = parser.call(@payload)

      guest = Guest.find_or_initialize_by(email: parsed[:guest][:email])
      guest.assign_attributes(parsed[:guest])
      guest.save!

      reservation = guest.reservations.build(parsed[:reservation])
      reservation.save!

      reservation
    end
  end
end
