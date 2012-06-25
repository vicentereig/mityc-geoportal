# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Mityc::Geoportal::SearchResults do

  before :each do
    @search_result = Mityc::Geoportal::SearchResults.parse(File.read('spec/data/measure_resultset.html'))
  end

  it 'should calculate page offsets' do
    @search_result.offsets == 10.step(90,10)
  end

  it 'should extract the total search result count from the happy text' do
    @search_result.smart_and_helpful_sentence.should match("En este momento se dispone de datos de 8713 estaciones de servicio")
  end
end
