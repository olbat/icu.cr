module ICU
  class Date
    def self.from(date_time : Time) : LibICU::UDate
      date_time.to_unix_ms.to_f
    end

    def self.from(year : Int32, month : Int32, day : Int32) : LibICU::UDate
      Date.from(Time.utc(year, month, day))
    end
  end
end
