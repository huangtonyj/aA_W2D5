class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @size = 0
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @size == 0
  end

  def get(key)
    current_node = @head 
    until current_node == @tail 
      return current_node.val if current_node.key == key 
      current_node = current_node.next
    end 
    nil
  end

  def include?(key)
    current_node = @head 
    until current_node == @tail 
      return true if current_node.key == key 
      current_node = current_node.next
    end 
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = @tail 
    new_node.prev = @tail.prev
    @tail.prev = new_node
    new_node.prev.next = new_node
    
    @size += 1
  end

  def update(key, val)
    current_node = @head 
    until current_node == @tail 
      if current_node.key == key 
        current_node.val = val
        break
      end 
      current_node = current_node.next
    end 
  end

  def remove(key)
    current_node = @head 
    until current_node == @tail 
      if current_node.key == key 
        current_node.next.prev = current_node.prev  
        current_node.prev.next = current_node.next
        break
      end 
      current_node = current_node.next
    end 
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail 
      prc.call(current_node)
      current_node = current_node.next
    end   
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
