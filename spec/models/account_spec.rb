require 'spec_helper'

describe Account do

	it " should make a valid account" do
		account = Account.new(name: 'alpha')
		account.should be_valid
	end

end
