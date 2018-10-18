class MenuCombinations
  attr_reader :target_price, :menu_items, :item_combinations

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
    @item_combinations = []
    parse_file
    find_combinations(@target_price, [])
    remove_duplicate_combinations
  end

  def remove_duplicate_combinations
    @item_combinations.each { |item_combination| item_combination.sort! }
    @item_combinations = @item_combinations.uniq
  end
  private :remove_duplicate_combinations

  def find_combinations(current_price, items_used)
     if current_price == 0
       @item_combinations << items_used
     elsif current_price < 0
       return
     else
       @menu_items.each do |item_name, item_price|
         new_items_used = items_used + [item_name]
         new_price = current_price - item_price
         find_combinations(new_price, new_items_used)
       end
     end
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

mc = MenuCombinations.new("test_menu.txt")
mc.item_combinations
