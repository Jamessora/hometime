# frozen_string_literal: true

require 'rails_helper'

describe Reservations::PayloadIdentifier do
  subject do
    described_class.call(payload)
  end

  context 'when payload is format 1 (guest at top level)' do
    let(:payload) { reservation_payload_format1 }

    it 'returns :format_1' do
      is_expected.to eq(:format_1)
    end
  end

  context 'when payload is format 2 (wrapped under reservation)' do
    let(:payload) { reservation_payload_format2 }

    it 'returns :format_2' do
      is_expected.to eq(:format_2)
    end
  end

  context 'when payload does not match any known format' do
    let(:payload) do
      { "foo" => "bar" }
    end

    it 'raises an unsupported format error' do
      expect { subject }.to raise_error('Unsupported payload format')
    end
  end
end
