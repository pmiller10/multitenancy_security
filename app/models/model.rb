  class Model < ActiveRecord::Base
    self.abstract_class = true

	def self.build_default_scope
      if method(:default_scope).owner != ActiveRecord::Base.singleton_class
        evaluate_default_scope { default_scope }
      elsif default_scopes.any?
        evaluate_default_scope do
          default_scopes.inject(relation) do |default_scope, scope|
            if scope.is_a?(Hash)
              default_scope.apply_finder_options(scope)
            elsif !scope.is_a?(ActiveRecord::Relation) && scope.respond_to?(:call)

							# This overrides the standard #build_default_scope method.
							# We override it to allow us to pass a Proc as a default_scope.
							# If the default_scope is a proc, then it will respond_to the #arity method.
							# Then it is evaluaeed as scope.call(self) rather than scope.call.
							# If you get a strange error with a different version of rails, then check 
							# the source code to see if this method has changed. This is from Rails version 3.2.1
              if scope.respond_to?(:arity) && scope.arity == 1
                scope = scope.call(self)
              else
                scope = scope.call
              end
              default_scope.merge(scope)
				 			# End of the different part.

            else
              default_scope.merge(scope)
            end
          end
        end
      end
    end

    default_scope do |model|
      model.where(:account_id => Account.current)
    end

  end
