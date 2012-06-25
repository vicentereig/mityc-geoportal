class Mityc::Geoportal::Province
  include HappyMapper, ActiveModel::Validations

  tag     'provincia'
  element :id,   String, tag: 'id_provincia'
  element :name, String, tag: 'nombre_provincia'

  validate :id,   presence: true
  validate :name, presence: true

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
      response.body
    end

    def response
      @response ||= Typhoeus::Request.get('http://geoportal.mityc.es/hidrocarburos/eess/provincias.do')
    end
  end
end