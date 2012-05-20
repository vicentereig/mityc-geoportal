class Mityc::Geoportal::Province
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag 'provincia'
  element :id,   String, tag: 'id_provincia'
  element :name, String, tag: 'nombre_provincia'

  def cities
    @cities ||= Mityc::Geoportal::City.by_province(self.id)
  end

  def name
    @name.strip
  end

  class << self
    def all
      @provinces ||= self.parse(provinces_xml)
    end

    protected
      def provinces_xml
        self.get('/provincias.do').body
      end
  end
end