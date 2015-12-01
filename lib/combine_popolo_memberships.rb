require 'combine_popolo_memberships/version'

# Takes multiple popolo membership arrays and combines them based on date.
module CombinePopoloMemberships
  def self.overlap(mem, term)
    mS = mem[:start_date].to_s.empty? ? '0000-00-00' : mem[:start_date].to_s
    mE = mem[:end_date].to_s.empty? ? '9999-99-99' : mem[:end_date].to_s
    tS = term[:start_date].to_s.empty? ? '0000-00-00' : term[:start_date].to_s
    tE = term[:end_date].to_s.empty? ? '9999-99-99' : term[:end_date].to_s

    return unless mS < tE && mE > tS
    (s, e) = [mS, mE, tS, tE].sort[1, 2]
    {
      _data: [mem, term],
      start_date: s == '0000-00-00' ? nil : s,
      end_date:   e == '9999-99-99' ? nil : e
    }
  end

  def self.combine(h)
    into_name, into_data, from_name, from_data = h.flatten
    from_data.product(into_data).map { |a, b| overlap(a, b) }.compact.map do |h|
      data = h.delete :_data
      h.merge(from_name => data.first[:id], into_name => data.last[:id])
    end.sort_by { |h| h[:start_date].to_s }
  end
end
