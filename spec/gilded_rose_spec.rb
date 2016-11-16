require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "lowers the sellin by 1" do
      expect(item.sell_in).to eq(4)
    end

    it "lowers the quality by 1" do
      expect(item.quality).to eq(9)
    end
  end

  context "when sell by date has passed" do
    let(:initial_sell_in) { -1 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "quality degrades twice as fast" do
      expect(item.quality).to eq(8)
    end
  end

  context "when item name is 'Aged Brie'" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { 'Aged Brie' }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "quality increases the older it gets" do
      expect(item.quality).to eq(11)
    end

    context "and quality is 50" do
      let(:initial_quality) { 50 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality cannot exceed by 50" do
        expect(item.quality).to be <= 50
      end
    end
  end

  context "with multiple items" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10),
      ]
    }

    before { update_quality(items) }

    it "normal item should should lower their sellin and quality by 1" do
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(9)
    end
  end
end
