module SSM
  def self.included(base)
    base.extend SSM::ClassMethods
  end

  module ClassMethods
    def states(*_states)
      _states.each do |state|
        define_state_boolean(state)
        define_state_scope(state)
      end
    end

    private
      def define_state_boolean(_state)
        method_name = "#{ _state }?"
        define_method method_name do
          self.state == _state.to_s
        end
      end

      def define_state_scope(_state)
        self.send :scope, _state, -> do
          where(state: _state)
        end
      end
  end

  def transition(from:)
    valid_states = [from].flatten

    if valid_states.include?(self.state.to_sym)
      return yield
    end
    raise SSM::InvalidTransition
  end
end
