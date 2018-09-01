class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0.hash if self.empty?
    
    arr = self.map.with_index do |el, idx|
      el.to_s.ord * (idx + 1)
    end
    
    arr.reduce() {|acc, el| acc ^ el.hash}    
  end
end

class String
  def hash
    self.chars.map do |char|
      char.ord
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.flatten.hash
  end
end
