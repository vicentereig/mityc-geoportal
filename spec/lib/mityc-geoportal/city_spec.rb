require 'spec_helper'

describe Mityc::Geoportal::City do
  it 'should map 46 cities from spec/data/municipios.xml' do
    cities = Mityc::Geoportal::City.parse(File.read('spec/data/municipios.xml'))
    cities.size.should == 46
  end

  it 'should download 46 cities for province 05' do
    cities = Mityc::Geoportal::City.by_province("05")
    cities.size.should == 46
  end
end