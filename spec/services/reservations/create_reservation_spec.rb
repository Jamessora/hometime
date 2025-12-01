# frozen_string_literal: true

require 'rails_helper'

describe Reservations::CreateReservation do
  subject do
    described_class.call(payload)
  end

  let(:email) { 'wayne_woodbridge@bnb.com' }

  context 'when payload is format 1' do
    let(:payload) { reservation_payload_format1 }

    it 'creates a new guest and a reservation' do
      expect { subject }
        .to change(Guest, :count).by(1)
        .and change(Reservation, :count).by(1)

      is_expected.to be_persisted
    end

    context 'when the guest already exists' do
      let!(:existing_guest) do
        create(:guest, email: email, first_name: 'Existing', last_name: 'Guest')
      end

      it 'reuses the existing guest and only creates a reservation' do
        expect { subject }
          .to change(Guest, :count).by(0)
          .and change(Reservation, :count).by(1)

        reservation = subject

        expect(reservation.guest).to eq(existing_guest)
        expect(reservation.guest.email).to eq(email)
      end
    end
  end

  context 'when payload is format 2' do
    let(:payload) { reservation_payload_format2 }

    it 'creates a new guest and a reservation' do
      expect { subject }
        .to change(Guest, :count).by(1)
        .and change(Reservation, :count).by(1)

      is_expected.to be_persisted
    end

    context 'when the guest already exists' do
      let!(:existing_guest) do
        create(:guest, email: email)
      end

      it 'reuses the existing guest and only creates a reservation' do
        expect { subject }
          .to change(Guest, :count).by(0)
          .and change(Reservation, :count).by(1)

        reservation = subject

        expect(reservation.guest).to eq(existing_guest)
        expect(reservation.guest.email).to eq(email)
      end
    end
  end

  context 'when payload format is unsupported' do
    let(:payload) do
      { "foo" => "bar" }
    end

    it 'raises an error' do
      expect { subject }.to raise_error('Unsupported payload format')
    end
  end
end
