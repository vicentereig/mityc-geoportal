# -*- encoding : utf-8 -*-
module Mityc::Geoportal
  class SearchResults
    include HappyMapper

    tag "td[@class='tdPaginator']"

    has_many :pages, String, tag: "div[@class='paginatorSquareNa']"
  end
end
