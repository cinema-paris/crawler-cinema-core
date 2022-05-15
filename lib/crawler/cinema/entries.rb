module Crawler
  class Cinema
    module Providers
      class Entries
        include Enumerable

        def initialize(&block)
          @fnc = block
        end

        def each(&block)
          @fnc.call(block)
        end
      end
    end
  end
end
