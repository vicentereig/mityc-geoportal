class Mityc::Geoportal::Fuel
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag "tipocombustible"

  element :id, Integer, tag: "id"
  element :name, String, tag: "nombre"

  def self.all
    @fuels ||= self.parse(fuels_xml)
  end

  # TODO: Properly implement an Identiy Map
  def measures
    @measures ||= Mityc::Geoportal::Measure.by_fuel(self.id)
  end

  protected
    def self.fuels_xml
      self.get('/combustibles.do', query: query_params).body
    end

    def self.query_params
      { tipoBusqueda: 0 }
    end
end