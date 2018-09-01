class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true 
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num >= 0 && num < @max 
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    @store[num % @num_buckets] << num unless include?(num)
  end

  def remove(num)
    @store[num % @num_buckets].delete(num)
  end

  def include?(num)
    @store[num % @num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets

    unless include?(num)
      @store[num % num_buckets] << num 
      @count += 1
    end 
  end
  
  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end 
      
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized_int_set = ResizingIntSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |el|
        resized_int_set.insert(el)
      end 
    end 
    @store = resized_int_set.store
  end
end
