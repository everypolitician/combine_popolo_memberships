require 'combine_popolo_memberships/version'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  def self.overlap(membership, term)
    membership_start_date = membership[:start_date].to_s.empty? ? '0000-00-00' : membership[:start_date].to_s
    membership_end_date = membership[:end_date].to_s.empty? ? '9999-99-99' : membership[:end_date].to_s
    term_start_date = term[:start_date].to_s.empty? ? '0000-00-00' : term[:start_date].to_s
    term_end_date = term[:end_date].to_s.empty? ? '9999-99-99' : term[:end_date].to_s

    return unless membership_start_date < term_end_date && membership_end_date > term_start_date
    start_date, end_date = [membership_start_date, membership_end_date, term_start_date, term_end_date].sort[1, 2]
    {
      _data: [membership, term],
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
