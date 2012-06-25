require 'spec_helper'

describe Mityc::Geoportal::City do
  it 'should map 52 provinces from spec/data/provincias.xml' do
    provinces = Mityc::Geoportal::Province.parse(File.read('spec/data/provincias.xml'))
    provinces.size.should == 52
  end

  it 'should download 52 provinces' do
    provinces = Mityc::Geoportal::Province.all
    provinces.size.should == 52
  end
end