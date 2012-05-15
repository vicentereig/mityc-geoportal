module Mityc
  module Geoportal
    def self.base_uri
      'http://geoportal.mityc.es/hidrocarburos/eess'
    end
  end
end

require "happymapper"
require "httparty"

require "mityc-geoportal/version"
require "mityc-geoportal/fuel"
require "mityc-geoportal/city"
require "mityc-geoportal/province"
require "mityc-geoportal/measure"
