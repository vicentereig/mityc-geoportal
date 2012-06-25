require 'active_support/core_ext/module/delegation'

class Mityc::Geoportal::SearchMeasuresByFuel

  SEARCH_ENDPOINT_URL = 'http://geoportal.mityc.es/hidrocarburos/eess/searchAddress.do'

  attr_accessor :search_results, :fuel, :requests

  delegate :each, :size, to: 'measures'

  def initialize(fuel)
    @fuel = fuel
  end

  def measures
    return @measures if @measures
    hydra    = Typhoeus::Hydra.new(max_concurrency: 5)
    fire_starter = self.request
    fire_starter.on_complete { |response|
      self.search_results = Mityc::Geoportal::SearchResults.parse(response.body)

      self.search_results.offsets.each { |offset|
        req = request(offset)
        req.on_complete { |response|
          Mityc::Geoportal::Measure.parse(response.body.encode('UTF-8', 'ISO-8859-15'))
        }
        hydra.queue(req)
      }

      Mityc::Geoportal::Measure.parse(response.body.encode('UTF-8', 'ISO-8859-15'))
    }
    hydra.queue fire_starter
    hydra.run

    @measures = self.requests.map(&:handled_response).flatten

  end

protected
  def request(offset=0)
    self.requests ||= []
    req = Typhoeus::Request.new(SEARCH_ENDPOINT_URL, params: query_params(offset))
    self.requests << req
    req
  end

  #   nomProvincia=01&
  #   nomMunicipio=ALTUBE&
  #   tipoCarburante=1&
  #   rotulo=&
  #   tipoVenta=false&
  #   nombreVia=&
  #   numVia=&
  #   codPostal=&
  #   economicas=false&
  #   tipoBusqueda=0&
  #   ordenacion=P&
  #   posicion=0
  def query_params(offset=0)
    { nomProvincia: '',  nomMunicipio: '', tipoCarburante: self.fuel.id, codPostal: '',
      rotulo: '',        tipoVenta: false, nombreVia: '',   numVia: '',
      economicas: false, tipoBusqueda: 0,  ordenacion: 'P', position: offset
    }
  end
end