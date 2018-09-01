class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets

    unless include?(key)
      # @store[key.hash % num_buckets] << key 
      self[key] << key 
      @count += 1
    end 
  end

  def include?(key)
    # @store[key.hash % num_buckets].include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      # @store[key.hash % num_buckets].delete(key)
      self[key].delete(key)
      @count -= 1
    end 
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # new_hash_set = HashSet.new(num_buckets * 2)
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        # new_hash_set.insert(el)
        new_store[el.hash % (num_buckets * 2)] << el
      end 
    end 
    # @store = new_hash_set.store
    @store = new_store
  end
end
