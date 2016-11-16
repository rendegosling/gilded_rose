require_relative 'item_wrapper'

class ConjuredWrapper < ItemWrapper
  def handle_quality
    decrement_quality
    decrement_quality
  end
end