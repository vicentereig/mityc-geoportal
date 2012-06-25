# -*- encoding : utf-8 -*-

module Mityc::Geoportal
  class SearchResults
    include HappyMapper
    tag "div"

    element  :smart_and_helpful_sentence, String, tag: "p"


    def count
      /\d+/.match(self.smart_and_helpful_sentence).to_s.to_i
    end

    def offsets
      10.step(self.count, 10)
    end
  end
end
