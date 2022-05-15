require 'active_support/core_ext/hash/keys'
require 'active_support/inflector'
require 'crawler/api'
require 'crawler/base'
require 'crawler/cinema/duration'
require 'crawler/cinema/entries'
require 'crawler/cinema/provider'
require 'crawler/cinema/session'

module Crawler
  class Cinema
    include Base

    def self.add_provider(provider_name, options = {})
      options.assert_valid_keys :insert_at

      Provider::PROVIDERS.insert(options[:insert_at] || -1, provider_name)
    end

    def self.providers
      Provider.new
    end

    def self.cinemas
      Provider::Entries.new(:cinemas)
    end

    def self.movies
      Provider::Entries.new(:movies)
    end
  end
end
