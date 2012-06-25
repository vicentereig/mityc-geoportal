# -*- encoding : utf-8 -*-
class Mityc::Geoportal::Fuel
  include HappyMapper, ActiveModel::Validations

  tag     "tipocombustible"
  element :id,   String, tag: "id"
  element :name, String, tag: "nombre"

  validate :id,   presence: true
  validate :name, presence: true

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
      response.body
    end

    def response
      @response ||= Typhoeus::Request.get('http://geoportal.mityc.es/hidrocarburos/eess/combustibles.do', params: query_params)
    end

    def query_params
      { tipoBusqueda: 0 }
    end
  end
end
