class ReservationSerializer < ApplicationSerializer
  attributes :adults,
             :children,
             :currency,
             :guest_count,
             :guest_id,
             :infants,
             :nights,
             :payout_price,
             :security_price,
             :status,
             :total_price,
             :start_date,
             :end_date,
             :created_at,
             :updated_at

  attribute :payout_price do |r|
    format_price(r.payout_price)
  end

  attribute :security_price do |r|
    format_price(r.security_price)
  end

  attribute :total_price do |r|
    format_price(r.total_price)
  end

  def self.format_price(value)
    return nil if value.nil?
    format("%.2f", value.to_d)
  end
end
