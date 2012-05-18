require 'spec_helper'

describe Account do

	it " should make a valid account" do
		account = Account.new(name: 'alpha')
		account.should be_valid
	end

	it " should validate that names are unique" do
		a = Account.create(name: 'a')
		invalid = Account.new(name: 'a')
		invalid.should be_invalid
	end
		

	it " should store the current account in the current thread" do
		@account = Account.create(name: 'alpha')
		Account.current = @account
		Account.current.should eq(@account)
	end

	it " should be threadsafe" do
		@other = Account.create(name: 'beta')
		Account.current = @account
		thread = Thread.new {
			Account.current.should eq(nil)
			Account.current = @other
		}
		thread.join
		other = thread[:account]
		Account.current.should eq(@account)
		other.should eq(@other)
	end

end
