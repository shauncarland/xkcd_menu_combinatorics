class MenuCombinations
  attr_reader :target_price, :menu_items, :item_combinations

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
    parse_file
    find_combinations
  end

  def find_combinations

  end
  private :find_combinations

  def parse_file
    file = File.open(@file_path)
    @menu_items = Hash.new

    file.each_line.with_index do |line, i|
      line = line.sub("$", "")

      if i == 0
        @target_price = line.to_f
      else
        menu_item = line.split(",")
        item = menu_item.first.gsub(" ", "_")
        price = menu_item.last.to_f

        @menu_items[item] = price
      end
    end
  end
  private :parse_file
end
