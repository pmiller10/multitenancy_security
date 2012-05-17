class Account < ActiveRecord::Base
	has_many :products

	class << self
		def current=(account)
			Thread.current[:account] = account
		end

		def current
			Thread.current[:account]
		end
	end

end
