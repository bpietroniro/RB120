class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def current_switch_state
    switch
  end

  private

  attr_accessor :switch
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
p machine.start
p machine.current_switch_state
p machine.stop
p machine.current_switch_state
