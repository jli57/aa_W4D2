# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}, presence: true
  validate :does_not_overlap_approved_request

  belongs_to :cat, dependent: :destroy

  def overlapping_requests
    # get a list of rental requests for this cat
    id = self.id || 0
    # other_requests = CatRentalRequest.find_by_sql(<<-SQL)
    #   SELECT *
    #   FROM cat_rental_requests AS a
    #   WHERE (
    #        '#{self.start_date}' BETWEEN a.start_date AND a.end_date
    #     OR '#{self.end_date}' BETWEEN a.start_date AND a.end_date
    #     OR ('#{self.start_date}' <= a.start_date AND '#{self.end_date}' >= a.end_date ) )
    #     AND a.id != #{id}
    # SQL

    CatRentalRequest
      .where("(? BETWEEN start_date AND end_date
         OR ? BETWEEN start_date AND end_date
         OR (? <= start_date AND ? >= end_date ) )
         AND id != ?", start_date, end_date, start_date, end_date, id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      self.errors[:start_date] << "This request overlaps with existing requests"
    end
  end

  def cat_name
    cat.name
  end
end
