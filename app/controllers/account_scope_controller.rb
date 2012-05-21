class AccountScopeController < ApplicationController

	around_filter :load_hosting_account

	def load_hosting_account
		account = Account.find_by_name!(params[:account_name])
		account.with { yield }
	end

	def default_html_options(options={})
		{:account_name => Account.current.name}
	end

end
