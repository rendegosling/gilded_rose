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
    if name != 'Sulfuras, Hand of Ragnaros'
      self.sell_in -= 1
    end
  end

  def handle_quality
    if name != 'Aged Brie' && name != 'Backstage passes to a TAFKAL80ETC concert'
      if name != 'Sulfuras, Hand of Ragnaros'
        decrement_quality
      end
    else
      increment_quality
      if name == 'Backstage passes to a TAFKAL80ETC concert'
        if sell_in < 10
          increment_quality
        end
        if sell_in < 6
          increment_quality
        end
      end
    end
    if sell_in < 0
      if name != "Aged Brie"
        if name != 'Backstage passes to a TAFKAL80ETC concert'
          if name != 'Sulfuras, Hand of Ragnaros'
            decrement_quality
          end
        else
          self.quality = self.quality - quality
        end
      else
        increment_quality
      end
    end
  end
end