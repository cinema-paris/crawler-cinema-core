require 'zlib'

module Crawler
  class Cinema
    module Session
      def self.parse(url)
        return {} if url.nil?

        uri = URI(url)
        query = URI.decode_www_form(uri.query.to_s).to_h
        domain_matches = uri.host.match(/((?<subdomain>.+)\.)?(?<domain>[^.]+\.[^.]+)$/)

        id = if domain_matches[:domain] == 'ticketingcine.fr'
               # https://www.ticketingcine.fr/?nc=0821&lang=fr&ids=24477
               "#{query['nc']}/#{query['ids']}"
             elsif domain_matches[:domain] == 'cinemaspathegaumont.com' && (session_matches = uri.fragment.match(%r{^/(?<id>C\d+)/booking$}))
               # https://s.cinemaspathegaumont.com/#/C3132S52221/booking
               session_matches[:id]
             elsif (session_matches = uri.path.match(%r{/(?<id>F\d+/D\d+/\w+)/?$}))
               # http://www.lebrady.fr/resa-part/CIP/F18965/D1560587400/VF
               # https://www.lescinemaschaplin.fr/denfert/reserver/F13772/D1559329200/VO/
               # https://legrandrex.cotecine.fr/reserver/F228974/D1558288800/VOST/
               session_matches[:id]
             else
               Zlib::crc32(uri.path + uri.query.to_s + uri.fragment.to_s)
             end

        {
          id: id,
          source: uri.host.gsub(%r{[^a-zA-Z0-9\-_]}, '_'),
          url: url
        }
      end
    end
  end
end
