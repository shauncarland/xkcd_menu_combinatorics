require 'spec_helper'

describe MenuCombinations do
  context "when a valid file is passed in" do
    let(:file_name) { "menu" }

    before(:each) do
      allow(File).to receive(:open).with(file_name).
        and_return(StringIO.new(file_data))
    end

    let(:menu_combinations) { MenuCombinations.new(file_name) }

    describe "when there is a combination of items that add up to the target price" do
      let(:file_data) do
<<-FILE_DATA
$4.00
foo,$1.00
bar,$2.00
buzz,$3.00
FILE_DATA
      end

      it "returns the combinations" do
        combinations = [
          ["foo", "foo", "foo", "foo"],
          ["bar", "foo", "foo"],
          ["buzz", "foo"],
          ["bar", "bar"]
        ]

        expect(menu_combinations.item_combinations).to eq(combinations)
      end
    end

    describe "when there are no combinations of items that add up to the target price" do
      let(:file_data) do
<<-FILE_DATA
$1.00
foo,$2.00
bar,$3.00
buzz,$4.00
FILE_DATA
      end

      it "returns a message to the user stating that there is no valid combination" do
        expect(menu_combinations.item_combinations).to eq("No combinations of menu items were found!")
      end
    end
  end
end
