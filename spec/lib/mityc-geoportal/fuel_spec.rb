# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Mityc::Geoportal::Fuel do
  it 'should map 52 provinces from spec/data/combustibles.xml' do
    fuels = Mityc::Geoportal::Fuel.parse(File.read('spec/data/combustibles.xml'))
    fuels.size.should == 8
  end

  it 'should download 52 provinces' do
    fuels = Mityc::Geoportal::Fuel.all
    fuels.size.should == 8
  end
end