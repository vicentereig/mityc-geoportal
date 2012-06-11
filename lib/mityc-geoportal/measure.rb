class Mityc::Geoportal::Measure
  include HappyMapper, HTTParty

  base_uri Mityc::Geoportal::base_uri

  tag 'tr[position()>4]'

  element :province_name, String, xpath: 'td[1]'
  element :city_name,     String, xpath: 'td[2]'
  element :address,       String, xpath: 'td[3]'
  element :margin,        String, xpath: 'td[4]'
  element :label,         String, xpath: 'td[7]'
  element :public_sale,   String, xpath: 'td[8]'
  element :data_source,   String, xpath: 'td[9]'
  element :schedule,      String, xpath: 'td[10]'
  element :measured_at,   String, xpath: 'td[5]'
  element :amount,        String, xpath: 'td[6]'

  def amount
    @amount.gsub(/,/, ".").to_f
  end

  def measured_at
    @measured_at = Date.new(*transform_measured_at)
  end

  def public_sale
    (@public_sale =~/^p$/i)? true : false
  end

  def data_source
    @data_source.strip
  end

  def schedule
    @schedule.strip
  end

  def province_name
    @province_name.strip
  end

  def city_name
    @city_name.strip
  end

  def address
    @address.strip
  end

  def margin
    @margin = @margin.strip
    if @margin =~ /^i$/i
      "left"
    elsif @margin =~/^d$/i
      "right"
    else
      "none"
    end
  end

  class << self
    attr_accessor :fuel_id

    def by_fuel(fuel_id)
      self.fuel_id = fuel_id
      @measures ||= self.parse(measures_html)
    end

    protected
      def measures_html
        response_body = self.get('/searchTotal.do', query: query_params).body
        response_body.encode('UTF-8', 'ISO-8859-15')
      end

      def query_params
        { tipoCons: 1, tipoBusqueda: 0, tipoCarburante: self.fuel_id }
      end
  end

  protected
    def transform_measured_at
      return @measured_at if @measured_at.is_a? Date
      @measured_at.split(/\//).map(&:to_i).reverse
    end
end
