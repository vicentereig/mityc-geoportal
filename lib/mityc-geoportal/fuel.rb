class Mityc::Geoportal::Fuel
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag "tipocombustible"

  element :id, Integer,  tag: "id"
  element :name, String, tag: "nombre"

  def measures
    @measures ||= Mityc::Geoportal::Measure.by_fuel(self.id)
  end

  def measures_by(field_name)
    self.measures.by_attribute(field_name) { |field_value, measure_group|
      yield field_value, measure_group
    }
  end

  class << self
    def all
      @fuels ||= self.parse(fuels_xml)
    end

    def by_id(fuel_id)
      self.all.find { |fuel| fuel.id = fuel_id}
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