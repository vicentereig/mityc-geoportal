# -*- encoding : utf-8 -*-
module Mityc::Geoportal
  class SearchResults
    include HappyMapper

    tag "td[@class='tdPaginator']"

    has_many :pages, String, tag: "div[@class='paginatorSquareNa']"

    def offsets
      self.pages.map.with_index { |_, page|
        offset = ((page+1)*10)
        yield offset if block_given?
        offset
      }
    end
  end
end
