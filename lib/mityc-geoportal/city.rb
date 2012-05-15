class Mityc::Geoportal::City
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag 'm'

  text_node :name, String

  attr_accessor :province_id

  def self.by_province(province_id)
    self.province_id = province_id
    self.parse(cities_xml)
  end

  protected
    def self.cities_xml
      self.get('/municipios.do', query: query_params).body
    end

    def self.query_params
      { tipoBusqueda: 0, idProvincia: self.province_id }
    end
end