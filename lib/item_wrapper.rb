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
    self.sell_in -= 1
  end

  def handle_quality
    decrement_quality
    if sell_in < 0
      decrement_quality
    end
  end

  def self.wrap(item)
    if item.name == 'Aged Brie'
      AgedBrieWrapper.new(item)
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePassWrapper.new(item)
    elsif item.name == 'Conjured'
      ConjuredWrapper.new(item)
    elsif item.name == 'Sulfuras, Hand of Ragnaros'
      LegendaryItemWrapper.new(item)
    else
      new(item)
    end
  end
end

class AgedBrieWrapper < ItemWrapper
  def handle_quality
    increment_quality
    if sell_in < 0
      increment_quality
    end
  end
end

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

class ConjuredWrapper < ItemWrapper
  def handle_quality
    decrement_quality
    decrement_quality
  end
end

class LegendaryItemWrapper < ItemWrapper
  def update
  end
end