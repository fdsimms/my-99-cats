class CatRentalRequest < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: STATUSES
  validate :cannot_have_overlapping_approved_requests

  belongs_to :cat


  def deny!
    self.update!(status: "DENIED")
  end

#   Move request status from PENDING to APPROVED.
# Save the model.
# Deny all conflicting rental requests.

  def pending?
    status == "PENDING"
  end

  def approve!
    self.transaction do
      self.update!(status: "APPROVED")
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  private

  def cannot_have_overlapping_approved_requests
    if self.status == 'APPROVED' && !overlapping_approved_requests.empty?
      errors.add(:status, "Overlapping requests cannot both be approved.")
    end
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def overlapping_requests
    CatRentalRequest.all
      .where("start_date <= ?", self.end_date)
      .where("end_date >= ?", self.start_date)
      .where(cat_id: self.cat_id)
      .where.not(id: self.id )
  end
end
