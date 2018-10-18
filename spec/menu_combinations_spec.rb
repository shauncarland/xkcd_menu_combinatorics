require 'spec_helper'
require 'tempfile'

describe MenuCombinations do
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
