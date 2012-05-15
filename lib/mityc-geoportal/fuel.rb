class Mityc::Geoportal::Fuel
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag "tipocombustible"

  element :id, Integer, tag: "id"
  element :name, String, tag: "nombre"

  # TODO: Properly implement an Identiy Map
  def measures
    @measures ||= Mityc::Geoportal::Measure.by_fuel(self.id)
  end
  class << self
    def all
      @fuels ||= self.parse(fuels_xml)
    end

    protected
      def fuels_xml
        self.get('/combustibles.do', query: query_params).body
      end

      def query_params
        { tipoBusqueda: 0 }
      end
  end
end