require 'combine_popolo_memberships/version'
require 'date-range'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  class Membership
    attr_reader :membership_hash

    def initialize(membership_hash)
      @membership_hash = membership_hash
    end

    def date_range
      @date_range ||= DateRange.new(start_date, end_date)
    end

    def overlap(other)
      o = date_range.overlap(other.date_range)
      return unless o
      membership_hash.merge(other.membership_hash).tap do |h|
        h[:start_date] = o.start_date
        h[:end_date] = o.end_date
      end
    end

    private

    def start_date
      @start_date ||=
        membership_hash[:start_date].to_s.empty? ? '0000-00-00' : membership_hash[:start_date].to_s
    end

    def end_date
      @end_date ||=
        membership_hash[:end_date].to_s.empty? ? '9999-99-99' : membership_hash[:end_date].to_s
    end
  end

  def self.combine(args)
    into_name, into_data, from_name, from_data = args.flatten
    memberships = from_data.product(into_data).map do |from, to|
      h = Membership.new(from).overlap(Membership.new(to))
      next unless h
      h.delete(:id)
      h.merge(from_name => from[:id], into_name => to[:id])
    end
    memberships.compact.sort_by { |h| h[:start_date] }
  end
end
