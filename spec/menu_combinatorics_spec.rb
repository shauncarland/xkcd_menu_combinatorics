require 'spec_helper'
require 'tempfile'

describe MenuCombinatorics do
  let(:file_name) { "menu" }
  before(:each) do
    allow(File).to receive(:open).with(file_name).
      and_return(StringIO.new(file_data))
  end

  describe "when there are no combinations of items to sum up to the target price" do
    let(:file_data) do
<<-FILE_DATA
$1.00
foo,$2.00
bar,$3.00
buzz,$4.00
FILE_DATA
    end

    it "returns a notification stating that there are no combinations" do

      expect(MenuCombinatorics.call(file_name)).
        to eq("No combinations of items that add up to your target price were found")
    end
  end

  describe "when there are combinations of items to sum up to the target price" do
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

      expect(MenuCombinatorics.call(file_name)).to eq(combinations)
    end
  end
end
