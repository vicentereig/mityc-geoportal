class Mityc::Geoportal::Province
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag 'provincia'
  element :id,   String, tag: 'id_provincia'
  element :name, String, tag: 'nombre_provincia'

  def cities
    @cities ||= Mityc::Geoportal::City.by_province(self.id)
  end

  def self.all
    @provinces ||= self.parse(provinces_xml)
  end

  protected
  def self.provinces_xml
    self.get('/provincias.do').body
  end

end