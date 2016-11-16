require_relative 'item_wrapper'

class AgedBrieWrapper < ItemWrapper
  def handle_quality
    increment_quality
    if sell_in < 0
      increment_quality
    end
  end
end