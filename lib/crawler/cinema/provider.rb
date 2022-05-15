module Crawler
  class Cinema
    class Provider
      include Enumerable

      PROVIDERS = []

      def each
        PROVIDERS.each do |provider_name|
          camelized = ActiveSupport::Inflector.camelize("crawler/cinema/providers/#{provider_name.to_s}")
          yield ActiveSupport::Inflector.constantize(camelized)
        end
      end

      class Entries
        include Enumerable

        def initialize(method_name)
          @method_name = method_name
        end

        def each
          providers = Provider.new
          providers.each do |provider|
            provider.public_send(@method_name).each do |entry|
              yield entry
            end
          end
        end
      end
    end
  end
end
