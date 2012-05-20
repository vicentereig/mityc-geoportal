# mityc-geoportal

Provides access to the fuel prices published by the Spanish Government.

# Usage

```ruby
include Mityc::Geoportal

fuels = Fuel.all

fuels.each { |fuel|
  puts "Downloading latest price update for #{fuel.name}..."
  fuel.measures.each { |measure|
    puts measure
  }
}

provinces = Provinces.all
provinces.each { |province|
  puts "Downloading cities for #{province.name}..."
  cities = province.cities
}

```