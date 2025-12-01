# frozen_string_literal: true

require 'rails_helper'

describe Reservation do
  subject(:reservation) { build(:reservation) }

  context 'with valid attributes' do
    it 'is valid' do
      is_expected.to be_valid
      is_expected.to be_new_record
    end
  end

  describe 'date validations' do
    context 'when start_date is on or after end_date' do
      before do
        reservation.start_date = Date.new(2021, 3, 16)
        reservation.end_date   = Date.new(2021, 3, 16)
      end

      it 'adds an error on start_date' do
        is_expected.not_to be_valid
        expect(reservation.errors[:start_date])
          .to include('must be a valid date')
      end
    end

    context 'when nights does not match the difference between dates' do
      before do
        reservation.start_date = Date.new(2021, 3, 12)
        reservation.end_date   = Date.new(2021, 3, 16)
        reservation.nights     = 3
      end

      it 'adds an error on nights' do
        is_expected.not_to be_valid
        expect(reservation.errors[:nights].first)
          .to match(/does not match the difference between start and end date/)
      end
    end
  end

  describe 'guest count validation' do
    context 'when guest_count does not equal adults + children' do
      before do
        reservation.adults      = 2
        reservation.children    = 1
        reservation.guest_count = 10
      end

      it 'adds an error on guest_count' do
        is_expected.not_to be_valid
        expect(reservation.errors[:guest_count].first)
          .to match(/must be equal to adults \+ children \(expected 3 guests\)/)
      end
    end
  end

  describe 'status validation' do
    context 'when status is not allowed' do
      before { reservation.status = 'unknown' }

      it 'adds an error on status' do
        is_expected.not_to be_valid
        expect(reservation.errors[:status].first)
          .to include('must be one of')
      end
    end
  end

  describe 'currency validation' do
    context 'when currency is not allowed' do
      before { reservation.currency = 'PHP' }

      it 'adds an error on currency' do
        is_expected.not_to be_valid
        expect(reservation.errors[:currency].first)
          .to include('must be one of')
      end
    end
  end
end
