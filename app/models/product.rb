class Product < Model
	belongs_to :account
	validate :current_account

	def current_account
		self.errors.add( :account_id, 'Mass Assignment Attack!') if account_id != Account.current.id
	end
end
