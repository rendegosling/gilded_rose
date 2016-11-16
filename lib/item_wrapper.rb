require 'delegate'

class ItemWrapper < SimpleDelegator
  def update
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
    return if name == 'Sulfuras, Hand of Ragnaros' 
    self.sell_in -= 1
  end

  def handle_quality
    return if name == 'Sulfuras, Hand of Ragnaros' 
    if name == 'Aged Brie' || name == 'Backstage passes to a TAFKAL80ETC concert'
      increment_quality
      if name == 'Backstage passes to a TAFKAL80ETC concert'
        if sell_in < 10
          increment_quality
        end
        if sell_in < 6
          increment_quality
        end
      end
    else
      decrement_quality
    end
    if sell_in < 0
      if name == "Aged Brie"
        increment_quality
      elsif name == 'Backstage passes to a TAFKAL80ETC concert'
          self.quality = self.quality - quality
      else
        decrement_quality
      end
    end
  end
end