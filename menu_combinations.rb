class MenuCombinations
  attr_reader :item_combinations

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
    @item_combinations = []
    parse_file
    find_combinations(@target_price, [])
  end

  private

  def find_combinations(current_price, items_used)
     if current_price == 0 && !@item_combinations.include?(items_used.sort)
       @item_combinations << items_used.sort
     elsif current_price < 0
       return
     else
       @menu_items.each do |item_name, item_price|
         new_items_used = items_used + [item_name]
         new_price = (current_price - item_price).round(2)

         find_combinations(new_price, new_items_used)
       end
     end
  end

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
end

mc = MenuCombinations.new("test_menu.txt")
mc.item_combinations
