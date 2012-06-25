# -*- encoding : utf-8 -*-
class Mityc::Geoportal::Measure
  include HappyMapper

  tag "tr[position()>1 and @class!='tdPaginator']"

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
  element :lat_lng_info,  Mityc::Geoportal::LatLngInfo, xpath: 'td[11]'

  delegate :lat, :lng, to: 'lat_lng_info'

  def self.by_fuel(fuel)
    search = Mityc::Geoportal::SearchMeasuresByFuel.new(fuel)
    search.measures
  end

  def amount
    @amount.gsub(/,/, ".").to_f
  end

  def measured_at
    @measured_at = self.transform_measured_at
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

protected
  def transform_measured_at
    return @measured_at if @measured_at.is_a? Date
    date_components = @measured_at.split(/\//).map(&:to_i).reverse
    Date.new(*date_components)
  end
end
