require 'date'
require 'date_range'

require 'combine_popolo_memberships/version'
require 'combine_popolo_memberships/date_proxy'
require 'combine_popolo_memberships/combiner'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  def self.combine(memberships)
    Combiner.new(memberships).combine
  end
end
