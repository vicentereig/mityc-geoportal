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

# License

Copyright (c) 2012 Vicente Reig Rincón de Arellano

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.