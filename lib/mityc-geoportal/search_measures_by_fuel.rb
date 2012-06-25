class Mityc::Geoportal::SearchMeasuresByFuel
  SEARCH_ENDPOINT_URL = 'http://geoportal.mityc.es/hidrocarburos/eess/searchAddress.do'

  attr_accessor :search_results, :city, :fuel

  def initialize(city, fuel)
    @city = city
    @fuel = fuel
  end

  def measures
    self.retrieve_measures
  end

protected
  def retrieve_measures
    measures = []
    hydra    = Typhoeus::Hydra.new(max_concurrency: 20)

    request.on_complete { |response|
      self.search_results  = Mytic::Geoportal::SearchResuls.parse(response.body)
      self.search_results.pages.each.with_index { |_, page|
        r = request(page+1) { |response|
          measures += Mytic::Geoportal::Measure.parse(response.body)
        }
        hydra.queue(r)
      }
      measures += Mytic::Geoportal::Measure.parse(response.body)
    }

    hydra.run
    measures
  end

  def request(offset=0)
    self.offset = offset
    Typhoeus::Request.new(SEARCH_ENDPOINT_URL, params: query_params)
  end

  def query_params

  end
end