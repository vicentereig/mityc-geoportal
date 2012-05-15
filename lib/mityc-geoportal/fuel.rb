class Mityc::Geoportal::Fuel
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag "tipocombustible"

  element :key, Integer, tag: "id"
  element :name, String, tag: "nombre"

  def self.all
    self.parse(fuels_xml)
  end

  protected
    def self.fuels_xml
      self.get('/combustibles.do', query: query_params).body
    end

    def self.query_params
      { tipoBusqueda: 0 }
    end
end