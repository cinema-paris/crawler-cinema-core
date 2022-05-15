module Crawler
  class Cinema
    module Duration
      SECONDS_PER_HOUR = 3600
      SECONDS_PER_MINUTE = 60

      module_function

      def parse(str)
        duration = 0
        duration_matches = str.match(/^((?<hours>\d+)(h|hours?))?\s*((?<minutes>\d+)(m|minutes?|mins?))?\s*((?<seconds>\d+)(s|seconds?|secs?))?$/i)

        if duration_matches
          duration += duration_matches[:hours].to_i * SECONDS_PER_HOUR if duration_matches[:hours]
          duration += duration_matches[:minutes].to_i * SECONDS_PER_MINUTE if duration_matches[:minutes]
          duration += duration_matches[:seconds].to_i if duration_matches[:seconds]
        end

        duration
      end
    end
  end
end
