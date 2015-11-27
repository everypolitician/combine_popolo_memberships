module CombinePopoloMemberships
  class DateProxy
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def start_date
      convert_to_date_object(data[:start_date], Date.new)
    end

    def end_date
      convert_to_date_object(data[:end_date], Date.new(9999, 12, 31))
    end

    private

    def convert_to_date_object(date, default)
      if date.is_a?(Date)
        date
      elsif date.to_s.empty?
        default
      else
        Date.parse(date)
      end
    end
  end
end
