class Scraping
  def self.get_category1
    agent = Mechanize.new
    page = agent.get("https://www.mercari.com/jp/category/")
    element = page.search(".category-list-box h3")
    element.each do |ele|
      # 検証用
      # puts ele.inner_text

      # 保存用
      product = Category1.new(name: ele.inner_text)
      product.save
    end
  end

  def self.get_category2
    agent = Mechanize.new
    page = agent.get("https://www.mercari.com/jp/category/")
    element = page.search(".category-list-individual-box-inner-box h4")
    id = 0
    element.each.with_index(1) do |ele, i|
      # 検証用
      # puts ele.inner_text

      # 保存用
      case i
      when 1..19
        id = 1
      when 20..33
        id = 2
      when 34..48
        id = 3
      when 49..61
        id = 4
      when 62..68
        id = 5
      when 69..79
        id = 6
      when 80..90
        id = 7
      when 91..100
        id = 8
      when 101..112
        id = 9
      when 113..121
        id = 10
      when 121..129
        id = 11
      when 130..136
        id = 12
      when 137..145
        id = 13
      end
      product = Category2.new(name: ele.inner_text, category1_id: id)
      product.save
    end
  end

  def self.get_category3
    agent = Mechanize.new
    page = agent.get("https://www.mercari.com/jp/category/")
    element = page.search(".category-list-individual-box-sub-sub-category-name a")
    id = 0
    element.each do |ele|
      # 検証用
      # e = ele.inner_text.strip!
      # if e == "すべて"
      #   id += 1
      # else
      #   puts e
      #   puts id
      # end

      # 保存用
      e = ele.inner_text.strip!
      if e == "すべて"
        id += 1
      else
        product = Category3.new(name: e, category2_id: id)
        product.save
      end
    end
  end
end
