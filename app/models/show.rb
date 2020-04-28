class Show < ApplicationRecord
  validates :title, :start_date, :end_date, presence: true
  validate :check_dates_order
  validate :check_dates_overlap

  private

  def check_dates_order
    return unless start_date.present? && end_date.present?

    if end_date < start_date
      errors.add(:start_date, :order)
      errors.add(:end_date, :order)
    end
  end

  def check_dates_overlap
    return unless start_date.present? && end_date.present?

    if Show.where("? >= start_date AND end_date >= ?", end_date, start_date).exists?
      errors.add(:start_date, :overlap)
      errors.add(:end_date, :overlap)
    end
  end
end
