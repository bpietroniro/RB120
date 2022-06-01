class CircularQueue
  def initialize(buffer_size)
    @queue = Array.new(buffer_size)
    @size = buffer_size
  end

  def enqueue(obj)
    if full?
      dequeue
    end
    new_spot = @queue.index(nil)
    @queue[new_spot] = obj
  end

  def dequeue
    if empty?
      nil
    else
      @queue[@size] = nil
      @queue.shift
    end
  end

  private

  def empty?
    @queue.all?(nil)
  end

  def full?
    @queue.length == @size && @queue.none?(nil)
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
