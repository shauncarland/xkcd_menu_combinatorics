require 'spec_helper'
require 'tempfile'

describe MenuCombinations do
  describe "#find_combinations" do
    let(:menu_combination) { MenuCombinations.new("foo") }
    let(:menu_items) { { 'foo' => 1, 'bar' => 2, 'buzz' => 3 } }
    let(:target_price) { 4 }

    before(:each) do
      allow_any_instance_of(MenuCombinations).to receive(:parse_file)
      menu_combination.instance_variable_set(:@menu_items, menu_items)
      menu_combination.instance_variable_set(:@target_price, target_price)

      # allow_any_instance_of(MenuCombinations).to receive
      # allow_any_instance_of(MenuCombinations).to receive(:menu_items).and_return({ 'foo' => 1, 'bar' => 2, 'buzz' => 3 })
      # allow_any_instance_of(MenuCombinations).to receive(:target_price).and_return(4)
    end

    it "returns the combinations" do
      combinations = [
        [ 'foo', 'foo', 'foo', 'foo' ],
        ['foo', 'foo', 'bar'],
        ['bar','bar'],
        ['foo','buzz']
      ]
      expect(menu_combination.item_combinations).to eq(combinations)
    end
  end

  # For example, for N = 4 and S = {1,2,3}, there are four solutions: {1,1,1,1},{1,1,2},{2,2},{1,3}. So output should be 4. For N = 10 and S = {2, 5, 3, 6}, there are five solutions: {2,2,2,2,2}, {2,2,3,3}, {2,2,6}, {2,3,5} and {5,5}. So the output should be 5.



  describe "#parse_file" do
    describe 'when the file is formatted correctly' do
      let(:file_name) { "menu" }

      let(:file_data) do
  <<-FILE_DATA
$15.05
mixed fruit,$2.15
french fries,$2.75
side salad,$3.35
hot wings,$3.55
mozzarella sticks,$4.20
sampler plate,$5.80"
  FILE_DATA
      end

      before(:each) do
        allow(File).to receive(:open).with(file_name).and_return(StringIO.new(file_data))
      end

      let(:menu_combinations) { MenuCombinations.new(file_name) }

      it 'parses the total price' do
        expect(menu_combinations.target_price).to eq(15.05)
      end

      it 'parses the menu items' do
        expect(menu_combinations.menu_items).to eq(
          {
            "mixed_fruit" => 2.15,
            "french_fries" => 2.75,
            "side_salad" => 3.35,
            "hot_wings" => 3.55,
            "mozzarella_sticks" => 4.2,
            "sampler_plate" => 5.8
          }
        )
      end
    end
  end
end
