class Array

  def flattify(flattened_array = [])
    self.each do |element|
      if element.is_a? Array
        element.flattify(flattened_array)
      else
        flattened_array << element
      end
    end
    flattened_array
  end

end
