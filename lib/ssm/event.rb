module SSM
  module Event
    def self.included(base)
      base.extend SSM::Event::ClassMethods
    end

    module ClassMethods
      def guards(*guards)
        @guards = guards
      end

      def guard(resource, &block)
        success = @guards&.reduce(true) do |memo, guard|
          resource.send(guard) && memo
        end
        return(yield) if success || @guards.blank?
        resource.reload
        false
      end

      def transition!(resource, to:, &block)
        @from = resource.state
        ActiveRecord::Base.transaction do
          resource.state = to
          resource.save!
          yield if block_given?
        end
      rescue ActiveRecord::RecordInvalid
        resource.state = @from
        raise SSM::InvalidTransition
      end
    end
  end
end
