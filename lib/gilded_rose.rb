require_relative 'item_wrapper'

def update_quality(items)
  items.each do |item|
    ItemWrapper.wrap(item).update
  end
end


######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
