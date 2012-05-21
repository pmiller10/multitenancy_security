require 'spec_helper'

describe Product do

	it " should belong to the current account" do
		account = Account.create(name: 'alpha')
		Account.current = account
		p = Product.create(name: "test", price: 22, account_id: Account.current.id)
		p.account.should eq(Account.current)
	end

	it " should only read products from the current account" do
		Account.delete_all
		@beta, @delta = Account.create(name: 'beta'), Account.create(name: 'delta')
		beta_product = Product.create(name: "b", price: 22, account_id: @beta.id)
		delta_product = Product.create(name: "d", price: 22, account_id: @delta.id)
		Account.current = @beta
		Product.all.should eq([beta_product])
	end

	it " should automatically associate products into the current account" do
		gamma = Account.create(name: 'gamma')
		Account.current = gamma
		p = Product.new(name: "c", price: 22)
		p.account.should eq(gamma)
	end

	it " should only update products associated with the current account" do
		epsilon, sigma = Account.create(name: 'epsilon'), Account.create(name: 'sigma')
		epsilon.with { Product.create(name: "e", price: 22, account_id: epsilon.id) }
		sigma.with { Product.create(name: "s", price: 22, account_id: sigma.id) }
		Account.current = epsilon
		Product.update_all('price = 33')
		e = Product.first
		e.price.should eq 33

		Account.current = sigma
		s = Product.first
		s.price.should eq 22

		# check that it won't delete records from another tenant.
		Product.delete_all
		Product.count.should eq(0)

		Account.current = epsilon
		Product.count.should > 0
	end

	it " shouldn't create products for another account" do
		account = Account.create(name: 'kappa')
		other = Account.create(name: 'iota')
		correct_count = account.with {correct_count = Product.count}
		# Create a product for another account.
		other.with do
			Product.create(:price => 45, :account_id => account.id)
		end
		account.with do 
			Product.count.should eq(correct_count)
		end
	end

end
