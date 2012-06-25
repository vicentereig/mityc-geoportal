require 'spec_helper'

describe Mityc::Geoportal::Measure do
  it 'should map 10 measures from spec/data/measure_resultset.html' do
    measures = Mityc::Geoportal::Measure.parse(File.read('spec/data/measure_resultset.html'))
    measures.size.should == 10
  end
end