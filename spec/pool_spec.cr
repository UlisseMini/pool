require "./spec_helper"

describe Pool do
  it "works" do
    out = [] of Int32

    pool = Pool.new(2)

    (1..4).each do |i|
      pool.spawn { sleep i.millisecond; out << i }
    end

    pool.wait

    out.should eq [1, 2, 3, 4]
  end
end
