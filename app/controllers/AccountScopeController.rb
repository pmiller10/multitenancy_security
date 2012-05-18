class AccountScopeController < ApplicationController

	around_filter :load_hosting_account

	def load_hosting_account
		account = Account.find_by_name!(params[:account_name])
		Account.current = account
		yield
	end

end
