module CombinePopoloMemberships
  class Combiner
    attr_reader :into_name, :into_data
    attr_reader :from_name, :from_data

    def initialize(memberships)
      @into_name, into_data, @from_name, from_data = memberships.flatten
      @into_data = into_data.map { |i| DateProxy.new(i) }
      @from_data = from_data.map { |f| DateProxy.new(f) }
    end

    def combine
      overlaps.map do |membership|
        data = membership.delete :_data
        membership.merge(from_name => data.first[:id], into_name => data.last[:id])
      end.sort_by { |h| h[:start_date].to_s }
    end

    private

    def overlaps
      from_data.product(into_data).map { |a, b| overlap(a, b) }.compact
    end

    def overlap(membership, term)
      membership_range = DateRange.new(membership.start_date, membership.end_date)
      term_range = DateRange.new(term.start_date, term.end_date)

      return unless membership_range.overlaps?(term_range)
      overlap = membership_range.overlap(term_range)
      {
        _data: [membership.data, term.data],
        start_date: overlap.start_date == Date.new ? nil : overlap.start_date.to_s,
        end_date:   overlap.end_date == Date.parse('9999-12-31') ? nil : overlap.end_date.to_s
      }
    end
  end
end
