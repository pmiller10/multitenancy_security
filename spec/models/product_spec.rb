require 'spec_helper'

describe Product do

	it " should make a valid product" do
		p = Product.new(name: "test", price: 22)
		p.should be_valid
	end

	it " should belong to the current account" do
		@account = Account.create(name: 'alpha')
		Account.current = @account
		current = Account.current
		p = Product.create(name: "test", price: 22, account_id: current.id)
		p.account.should eq(current)
	end

end
