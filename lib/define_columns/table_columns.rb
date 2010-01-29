class TableColumns

  attr_accessor :columns

  def initialize(cols)
    @columns = cols.map { |c| TableColumn.new(c) }
  end

  def add(cols)
    new_cols = cols.map { |c| TableColumn.new(c) }
    @columns = @columns + new_cols
  end

  def hide(cols)
    @columns = @columns.reject { |col| cols.include?(col.name) }
  end

  def show(col, &blk)
    index = @columns.map(&:name).index(col.to_s)
    @columns[index].apply(&blk)
  end

end
