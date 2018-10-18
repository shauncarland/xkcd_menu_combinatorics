require 'spec_helper'
require 'tempfile'

describe MenuCombinations do
  describe "#parse_file" do
    describe 'when the file is formatted correctly' do
      let(:file) do
        Tempfile.new(
          "$15.05
          mixed fruit,$2.15
          french fries,$2.75
          side salad,$3.35
          hot wings,$3.55
          mozzarella sticks,$4.20
          sampler plate,$5.80"
        )
      end

      let(:menu_combinations) { MenuCombinations.new(file) }

      it 'parses the total price' do
        expect(menu_combinations.target_price).to eq(15.05)
      end

      it 'parses the menu items' do
        expect(menu_combinations.menu_items).to eq(
          {
            mixed_fruit: 2.15,
            french_fries: 2.75,
            side_salad: 3.35,
            hot_wings: 3.55,
            mozzarella_sticks: 4.2,
            sampler_plate: 5.8
          }
        )
      end
    end
    # describe "when a bad file" do
    #   l
    # end
  # end
  # describe '#find_combinations' do
  #   describe "when there are multiple menu items" do
  #     let(:menu_prices) { [1,2,3] }
  #     let(:target_price) { 4 }
  #     let(:menu) { Menu.new(menu_prices: menu_prices, target_price: target_price) }
  #
  #     it "returns the correct combinations to hit the target price" do
  #       expect(menu.find_combinations).to eq(5)
  #     end
  #   end
    # it 'test' do
    #   expect(1).to eq(2)
    # end
  end
end
