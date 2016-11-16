require 'delegate'

class ItemWrapper < SimpleDelegator
  def update
    return if name == 'Sulfuras, Hand of Ragnaros' 
    handle_sell_in
    handle_quality
  end

  def increment_quality
    if quality < 50
      self.quality += 1
    end
  end

  def decrement_quality
    if quality > 0
      self.quality -= 1
    end
  end

  def handle_sell_in
    self.sell_in -= 1
  end

  def handle_quality
    if name == 'Aged Brie'
      increment_quality
      if sell_in < 0
        increment_quality
      end
    elsif name == 'Backstage passes to a TAFKAL80ETC concert'
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
    elsif name == 'Conjured'
      decrement_quality
      decrement_quality
    else
      decrement_quality
      if sell_in < 0
        decrement_quality
      end
    end
  end
end