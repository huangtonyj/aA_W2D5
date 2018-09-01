require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    the_linked_list = @store[key.hash % num_buckets]
    
    unless the_linked_list.include?(key)
      the_linked_list.append(key, val)
      @count += 1
    else
      the_linked_list.update(key,val)
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    the_linked_list = @store[key.hash % num_buckets]
    if the_linked_list.include?(key)
      the_linked_list.remove(key)
      @count -= 1
    end 
  end

  def each(&prc)
    @store.each do |linkedlist|
      linkedlist.each do |key, val|
        prc.call(key, val)
      end 
    end 
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
