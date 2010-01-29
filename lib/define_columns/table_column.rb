class TableColumn

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def header
    @name.humanize
  end

  def show(subject)
    if defined?(@proc)
      @proc.call subject.send(@name.to_sym)
    else
      subject.send @name.to_sym
    end

  end

  def apply(&blk)
    @proc = blk
  end

end


