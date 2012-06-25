# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Mityc::Geoportal::Measure do

  before :each do
    @measures = Mityc::Geoportal::Measure.parse(File.read('spec/data/measure_resultset.html'))
  end

  it 'should map 10 measures from spec/data/measure_resultset.html' do
    @measures.size.should == 10
  end

  it 'should extract geo coordinates from deeply fucked inline javascript call' do
    measure = @measures.first
    measure.lat.should == ''
  end
end
