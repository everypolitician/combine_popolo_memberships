require 'combine_popolo_memberships/version'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  class Membership
    attr_reader :data

    def initialize(data)
      @data = data
      @start_date = data[:start_date]
      @end_date = data[:end_date]
    end

    def start_date
      if @start_date.to_s.empty?
        '0000-00-00'
      else
        @start_date.to_s
      end
    end

    def end_date
      if @end_date.to_s.empty?
        '9999-99-99'
      else
        @end_date.to_s
      end
    end
  end

  def self.overlap(m, t)
    membership = Membership.new(m)
    term = Membership.new(t)

    return unless membership.start_date < term.end_date && membership.end_date > term.start_date
    start_date, end_date = [membership.start_date, membership.end_date, term.start_date, term.end_date].sort[1, 2]
    {
      _data: [membership.data, term.data],
      start_date: start_date == '0000-00-00' ? nil : start_date,
      end_date:   end_date == '9999-99-99' ? nil : end_date
    }
  end

  def self.combine(memberships)
    into_name, into_data, from_name, from_data = memberships.flatten
    from_data.product(into_data).map { |a, b| overlap(a, b) }.compact.map do |membership|
      data = membership.delete :_data
      membership.merge(from_name => data.first[:id], into_name => data.last[:id])
    end.sort_by { |h| h[:start_date] }
  end
end
