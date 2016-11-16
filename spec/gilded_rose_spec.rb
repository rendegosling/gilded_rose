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

  context "when item name is 'Sulfuras, Hand of Ragnaros'" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { 'Sulfuras, Hand of Ragnaros' }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "has no sell date" do
      expect(item.sell_in).to eq(5)
    end

    it "doesnt decrease quality" do
      expect(item.quality).to eq(10)
    end
  end

  context "when item name is 'Backstage passes to a TAFKAL80ETC concert'" do
    let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
    let(:initial_quality) { 10 }

    context "and sell in is greater than 10" do
      let(:initial_sell_in) { 11 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality increases by 1" do
        expect(item.quality).to eq(11)
      end
    end

    context "and sell in is 10" do
      let(:initial_sell_in) { 10 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality increases by 1" do
        expect(item.quality).to eq(12)
      end
    end

    context "and sell in is 6" do
      let(:initial_sell_in) { 10 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality increases by 1" do
        expect(item.quality).to eq(12)
      end
    end

    context "and sell in is 5" do
      let(:initial_sell_in) { 5 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality increases by 1" do
        expect(item.quality).to eq(13)
      end
    end

    context "and sell in is 1" do
      let(:initial_sell_in) { 1 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality increases by 1" do
        expect(item.quality).to eq(13)
      end
    end

    context "and sell in is 0" do
      let(:initial_sell_in) { 0 }
      let(:item) { Item.new(name, initial_sell_in, initial_quality) }

      before { update_quality([item]) }

      it "quality is 0" do
        expect(item.quality).to eq(0)
      end
    end
  end

  context "when item name is 'Conjured'" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { 'Conjured' }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "items degrade in quality twice as fast as normal items" do
      expect(item.quality).to eq(8)
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
