# coding: utf-8
module PrivateMessages
  module Models
    module PrivateMessage
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def is_private_message(options = {})
          class_attribute :options
          self.options = options

          klass_name = options[:class_name] ||= "User"

          belongs_to :sender, :class_name => klass_name, :foreign_key => 'sender_id'
          belongs_to :recipient, :class_name => klass_name, :foreign_key => 'recipient_id'

          scope :unread, where("read_at is null")

          def around_user(user)
            klass_name.constantize.where("sender_id = ? or recipient_id = ?", user.id, user.id)
          end

          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end
        end
      end

      module InstanceMethods
        def unread?
          !self.read?
        end

        def read?
          !self.read_at.blank?
        end

        def read!
          self.update_attribute(:read_at, Time.now)
        end
      end
    end
  end
end
