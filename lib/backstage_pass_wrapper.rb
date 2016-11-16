require_relative 'item_wrapper'

class BackstagePassWrapper < ItemWrapper
  def handle_quality
    increment_quality
    if sell_in < 10
      increment_quality
    end
    if sell_in < 6
      increment_quality
    end
    if sell_in < 0
      self.quality = self.quality - quality
    end
  end
end