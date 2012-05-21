class Account < ActiveRecord::Base
	has_many :products

	validates :name, :uniqueness => true

	class << self
		def current=(account)
			Thread.current[:account] = account
		end

		def current
			Thread.current[:account]
		end
	end

	def with
		Account.current = self
		yield
	end
end
