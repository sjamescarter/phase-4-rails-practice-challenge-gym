class Client < ApplicationRecord
  has_many :memberships
  has_many :gyms, through: :memberships

  def total_dues
    total= 0
    self.memberships.each { |membership| total += membership.charge }
    total
  end
end
