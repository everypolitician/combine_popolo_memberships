require 'combine_popolo_memberships/version'
require 'date'
require 'date_range'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  class Membership
    attr_reader :data

    def initialize(data)
      @data = data
      @start_date = data[:start_date]
      @end_date = data[:end_date]
      @range = DateRange.new(start_date, end_date)
    end

    def start_date
      if @start_date.to_s.empty?
        Date.new
      else
        Date.parse(@start_date.to_s)
      end
    end

    def end_date
      if @end_date.to_s.empty?
        Date.parse('9999-12-31')
      else
        Date.parse(@end_date.to_s)
      end
    end

    def range
      @range ||= DateRange.new(start_date, end_date)
    end
  end

  def self.overlap(m, t)
    membership = Membership.new(m)
    term = Membership.new(t)

    return unless membership.range.overlaps?(term.range)
    overlap = membership.range.overlap(term.range)
    {
      _data: [membership.data, term.data],
      start_date: overlap.start_date == Date.new ? nil : overlap.start_date,
      end_date:   overlap.end_date == Date.parse('9999-12-31') ? nil : overlap.end_date
    }
  end

  def self.combine(memberships)
    into_name, into_data, from_name, from_data = memberships.flatten
    from_data.product(into_data).map { |a, b| overlap(a, b) }.compact.map do |membership|
      data = membership.delete :_data
      string_dates(membership).merge(from_name => data.first[:id], into_name => data.last[:id])
    end.sort_by { |h| h[:start_date] }
  end

  def self.string_dates(membership)
    membership[:start_date] = membership[:start_date].to_s
    membership[:end_date] = membership[:end_date].to_s
    membership
  end
end
