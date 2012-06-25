class Mityc::Geoportal::City
  include HappyMapper, ActiveModel::Validations

  tag 'm'

  content :name, String

  validate :name, presence: true

  def name
    @name.strip
  end

  def measures
    Measure.by_city(self.name)
  end

  class << self
    attr_accessor :province_id

    def by_province(province_id)
      self.province_id = province_id
      @cities = self.parse(cities_xml).select(&:valid?)
    end

  protected
    def cities_xml
      response.body
    end

    def query_params
      { tipoBusqueda: 0, idProvincia: self.province_id }
    end

    def response
      @response ||= Typhoeus::Request.get('http://geoportal.mityc.es/hidrocarburos/eess/municipios.do', params: query_params)
    end
  end
end