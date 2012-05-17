require 'spec_helper'

describe Product do

	it " should make a valid product" do
		p = Product.new(name: "test", price: 22)
		p.should be_valid
	end

end
