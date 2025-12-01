# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :guest

  ALLOWED_STATUSES = %w[
    accepted
    cancelled
    pending
  ].freeze

  ALLOWED_CURRENCIES = %w[
    AUD
    USD
  ].freeze

  DATE_FORMAT = /\A\d{4}-\d{2}-\d{2}\z/.freeze

  validates :adults,
            :children,
            :currency,
            :end_date,
            :guest_count,
            :infants,
            :nights,
            :payout_price,
            :security_price,
            :start_date,
            :status,
            :total_price,
            presence: true

  # Adults must be at least 1
  validates :adults,
            :guest_count,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }

  # Included nights >= 0 in case same day checkout will be supported in the future.
  validates :children,
            :infants,
            :nights,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :currency,
            inclusion: {
              in: ALLOWED_CURRENCIES,
              message: "must be one of: #{ALLOWED_CURRENCIES.join(', ')}"
            }

  validates :payout_price, :security_price, :total_price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  
  validates :start_date,
            :end_date,
            format: {
              with: DATE_FORMAT,
              message: "must be in YYYY-MM-DD format"
            }
  
  validates :status,
            inclusion: {
              in: ALLOWED_STATUSES,
              message: "must be one of: #{ALLOWED_STATUSES.join(', ')}"
            }

  validate :validate_dates_and_nights

  private

  def validate_dates_and_nights
    return unless start_date.present? && end_date.present? && nights.present?

    validate_date_order
    validate_nights_calculation
  end

  def validate_date_order
    if start_date >= end_date
      errors.add(:start_date, "must be a valid date")
    end
  end

  def validate_nights_calculation
    calculated_nights = (end_date - start_date).to_i

    if nights.to_i != calculated_nights
      errors.add(:nights, "does not match the difference between start and end date (calculated #{calculated_nights} nights)")
    end
  end
end
