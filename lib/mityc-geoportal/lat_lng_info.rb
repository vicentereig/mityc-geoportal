# -*- encoding : utf-8 -*-
class Mityc::Geoportal::LatLngInfo
  include HappyMapper

  PATTERN = /(-?\d+\.\d+)\,(-?\d+\.\d+)/

  tag "img"

  attribute :geo_info, String, tag: 'onClick'

  def lat
    @lat = $1 if @geoinfo =~ PATTERN
  end

  def lng
    @lng = $2 if @geoinfo =~ PATTERN
  end
end