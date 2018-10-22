module MenuCombinatorics
  def self.call(file_path)
    menu_items = FileParser.parse_file(file_path)
    CombinatoricsGenerator.call(menu_items)
  end

  class CombinatoricsGenerator
  end

  class FileParser
  end
end
