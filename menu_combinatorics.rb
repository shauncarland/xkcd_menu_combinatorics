module MenuCombinatorics
  def self.call(file_path)
    parsed_file = FileParser.new(file_path)

    MenuCombinations.new(parsed_file.menu_items, parsed_file.target_price)
      .item_combinations
  end

  class MenuCombinations
    attr_reader :item_combinations

    def initialize(menu_items, target_price)
      @menu_items = menu_items
      @item_combinations = []
      find_combinations(target_price, [])

      if @item_combinations.empty?
        @item_combinations = "No combinations of items that add up to your target price were found"
      end
    end

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
    private :find_combinations
  end

  class FileParser
    attr_reader :menu_items, :target_price

    def initialize(file_path)
      parse_file(file_path)
    end

    def parse_file(file_path)
      file = File.open(file_path)
      @menu_items = Hash.new

      file.each_line.with_index do |line, i|
        line = line.sub("$", "")

        if i == 0
          @target_price = line.to_f
        else
          menu_item = line.split(",")
          item = menu_item.first
          price = menu_item.last.to_f

          @menu_items[item] = price
        end
      end
    end
  end
end
