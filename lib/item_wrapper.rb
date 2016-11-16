require 'delegate'

class ItemWrapper < SimpleDelegator
  def update
    if self.name != 'Aged Brie' && self.name != 'Backstage passes to a TAFKAL80ETC concert'
      if self.name != 'Sulfuras, Hand of Ragnaros'
        decrement_quality
      end
    else
      increment_quality
      if self.name == 'Backstage passes to a TAFKAL80ETC concert'
        if self.sell_in < 11
          increment_quality
        end
        if self.sell_in < 6
          increment_quality
        end
      end
    end
    if self.name != 'Sulfuras, Hand of Ragnaros'
      self.sell_in -= 1
    end
    if self.sell_in < 0
      if self.name != "Aged Brie"
        if self.name != 'Backstage passes to a TAFKAL80ETC concert'
          if self.name != 'Sulfuras, Hand of Ragnaros'
            decrement_quality
          end
        else
          self.quality = self.quality - self.quality
        end
      else
        increment_quality
      end
    end
  end

  def increment_quality
    if self.quality < 50
      self.quality += 1
    end
  end

  def decrement_quality
    if self.quality > 0
      self.quality -= 1
    end
  end
end