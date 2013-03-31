# coding: utf-8
module PrivateMessages
  module Models
    module PrivateUser
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def has_private_messages(options = {})
          class_attribute :options
          klass_name = options[:class_name] ||= "Message"
          table_name = klass_name.constantize.table_name

          has_many :outbox_messages, :class_name => klass_name,
             :foreign_key => 'sender_id', :include => :recipient,
             :order => "#{table_name}.created_at desc"

          has_many :inbox_messages, :class_name => klass_name,
             :foreign_key => 'recipient_id', :include => :sender,
             :order => "#{table_name}.created_at desc"

          unless included_modules.include? InstanceMethods
            include InstanceMethods
          end

          self.options = options
        end
      end

      module InstanceMethods
        def unread_messages
          self.inbox_messages.unread
        end

        def is_sender_of?(message)
          message.sender_id == self.id
        end

        def is_recipient_of?(message)
          message.recipient_id == self.id
        end

        def has_message?(message)
          self.is_sender_of?(message) || self.is_recipient_of?(message)
        end
      end
    end
  end
end
