require 'spec_helper'
require 'tempfile'

describe MenuCombinatorics do
  context "when a valid file is passed in" do
    let(:file_name) { "menu" }

    let(:file_data) do
<<-FILE_DATA
$4.00
foo,$1.00
bar,$2.00
buzz,$3.00
FILE_DATA
    end

    before(:each) do
      allow(File).to receive(:open).with(file_name).
        and_return(StringIO.new(file_data))
    end

    # let(:menu_combinations) { MenuCombinations.new(file_name) }

    it "returns the combinations" do
      combinations = [
        ["foo", "foo", "foo", "foo"],
        ["bar", "foo", "foo"],
        ["buzz", "foo"],
        ["bar", "bar"]
      ]

      expect(MenuCombinatorics.call(file_name)).to eq(combinations)
    end
  end
end
