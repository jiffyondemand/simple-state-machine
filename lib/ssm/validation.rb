module SSM
  def self.state_validation(*states, &block)
    states.each do |state|
      is_state = (state.to_s + "?").to_sym
      with_options if: is_state do |resource|
        yield resource
      end
    end
  end
end
