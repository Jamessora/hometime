require 'rails_helper'

describe Reservations::Parsers::Format2 do
  subject do
    described_class.call(payload)
  end

 let(:payload) { reservation_payload_format2 }

  it 'normalizes guest attributes' do
    expect(subject[:guest]).to eq(
      email:         'wayne_woodbridge@bnb.com',
      first_name:    'Wayne',
      last_name:     'Woodbridge',
      phone_numbers: [ '639123456789', '639123456789' ]
    )
  end

  it 'normalizes reservation attributes' do
    expect(subject[:reservation]).to include(
      adults:         2,
      children:       2,
      currency:       'AUD',
      end_date:       '2021-03-16',
      guest_count:    4,
      infants:        0,
      nights:         4,
      payout_price:   '3800.00',
      security_price: '500.00',
      start_date:     '2021-03-12',
      status:         'accepted',
      total_price:    '4500.00'
    )
  end

  context 'when children and infants are missing in guest_details' do
    let(:payload) do
    reservation_payload_format2(
      'reservation' => {
        'guest_details' => {
          'number_of_children' => nil,
          'number_of_infants'  => nil
        }
      }
    )
  end

    it 'defaults children and infants to 0' do
      reservation = subject[:reservation]

      expect(reservation[:children]).to eq(0)
      expect(reservation[:infants]).to eq(0)
    end
  end
end
