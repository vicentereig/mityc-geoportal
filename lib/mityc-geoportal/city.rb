class Mityc::Geoportal::City
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag 'm'

  content :name, String

  def name
    @name.strip
  end

  class << self
    attr_accessor :province_id

    def by_province(province_id)
      self.province_id = province_id
      @cities ||= self.parse(cities_xml)
    end

    protected
      def cities_xml
        self.get('/municipios.do', query: query_params).body
      end

      def query_params
        { tipoBusqueda: 0, idProvincia: self.province_id }
      end
  end
end