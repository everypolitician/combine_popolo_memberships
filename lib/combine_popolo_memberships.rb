require 'combine_popolo_memberships/version'
require 'date-range'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  class Membership
    def initialize(raw)
      @raw = raw
    end

    def start_date
      @start_date ||= raw[:start_date].to_s.empty? ? '0000-00-00' : raw[:start_date].to_s
    end

    def end_date
      @end_date ||= raw[:end_date].to_s.empty? ? '9999-99-99' : raw[:end_date].to_s
    end

    def date_range
      @date_range ||= DateRange.new(start_date, end_date)
    end

    def overlap(other)
      o = date_range.overlap(other.date_range)
      return unless o
      {}.merge(to_h).merge(other.to_h).tap do |h|
        h[:start_date] = o.start_date
        h[:end_date] = o.end_date
      end
    end

    def to_h
      raw
    end

    private

    attr_reader :raw
  end

  def self.combine(h)
    into_name, into_data, from_name, from_data = h.flatten
    from_data.product(into_data).map do |from, to|
      h = Membership.new(from).overlap(Membership.new(to))
      next unless h
      h.delete(:id)
      h.merge(from_name => from[:id], into_name => to[:id])
    end.compact.sort_by { |h| h[:start_date].to_s }
  end
end
