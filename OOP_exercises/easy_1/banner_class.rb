class Banner
  def initialize(message, banner_width=message.size + 2)
    @message = message
    if banner_width < message.size
      @banner_width = message.size + 2
    elsif (banner_width - message.size).odd?
      @banner_width = banner_width + 1
    else
      @banner_width = banner_width
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def buffer_length
    (@banner_width - @message.size)/2
  end

  def horizontal_rule
    "+" + "-" * @banner_width + "+"
  end

  def empty_line
    '|' + ' ' * @banner_width + '|'
  end

  def message_line
    "|" + " " * buffer_length + "#{@message}" + " " * buffer_length + "|"
  end
end


banner = Banner.new('To boldly go where no one has gone before.', 50)
puts banner
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end
banner = Banner.new('', 6)
puts banner
=begin
+--+
|  |
|  |
|  |
+--+
=end
