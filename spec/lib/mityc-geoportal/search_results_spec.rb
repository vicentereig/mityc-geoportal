# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Mityc::Geoportal::SearchResults do
  it 'should map 1 SearchResults instance from spec/data/measure_resultset.html' do
    search_results = Mityc::Geoportal::SearchResults.parse(File.read('spec/data/measure_resultset.html'))
    search_results.size.should == 1
    search_result  = search_results.pop
    search_result.pages.size.should == 9
  end

  it 'should calculate page offsets' do
    search_results = Mityc::Geoportal::SearchResults.parse(File.read('spec/data/measure_resultset.html'))
    search_results.size.should == 1
    search_result  = search_results.pop
    search_result.offsets == 10.step(90,10)
  end
end
