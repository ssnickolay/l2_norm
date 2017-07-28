require 'json'

class L2Norm
  class << self
    def perform(v1, v2)
      sum = v1.each.with_index.inject(0) do |memo, (val, i)|
        memo = memo + (val - v2[i]).abs ** 2
      end
      Math.sqrt(sum)
    end
  end
end

def vector_of(photo)
  file = File.read(File.path("photos/#{ photo }.jpg.json"))
  json = JSON.parse(file)[0]["Signature"]
end

SETS = %w(5010136539 5019411253)
VERSIONS = %w(ВУ1 ВУ2 УЦ)

SETS.each do |set|
  VERSIONS.combination(2).each do |(ver1, ver2)|
    photo1 = [set, ver1].join
    photo2 = [set, ver2].join
    puts "D(L2)[#{photo1}, #{photo2}]: #{ L2Norm.perform(vector_of(photo1), vector_of(photo2)) }"
  end
end
