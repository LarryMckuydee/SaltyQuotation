class RelabelController < ApplicationController
  def index
    @relabels = Relabel.all
    @woven_tags = WovenTag.all
    @exchange_rate = ConversionRate.last.exchange_rate
  end
end
