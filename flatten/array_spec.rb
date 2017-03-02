require File.expand_path(File.join(File.dirname(__FILE__), 'array'))

describe Array, '#flattify' do

  it 'returns an array' do
    expect([].flattify.class).to be(Array)
  end

  context 'not nested' do
    it 'returns itself' do
      expect([].flattify).to eq([])
      expect([1, 2].flattify).to eq([1, 2])
    end
  end

  context 'nested one level deep' do
    it 'returns a flattend array' do
      expect([1, [2]].flattify).to eq([1, 2])
    end
  end

  context 'nested two levels deep' do
    it 'returns a flattend array' do
      expect([1, [2, [3, 4]]].flattify).to eq([1, 2, 3, 4])
    end
  end

  context 'arbitrarily nested' do
    it 'returns a flattend array' do
      expect([[1, 2, [3]], 4].flattify).to eq([1, 2, 3, 4])
    end
  end

end
