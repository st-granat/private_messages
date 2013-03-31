private_messages
================

Sending Messages beetween users. Rails + Devise

## Установка

Install gem:

    gem "private_messages"

Migrations:

1. Create Users

2. Create Messages

For example:

    def change
      # Messages
      create_table :messages do |t|
        t.integer   :sender_id
        t.integer   :recipient_id
        t.string    :subject
        t.text      :body
        t.datetime  :read_at
        t.integer   :parent_id
        t.integer   :lft
        t.integer   :rgt
        t.integer   :depth
        t.timestamps
      end

      add_index :messages, :sender_id
      add_index :messages, :recipient_id
    end

Models:

user.rb:

    has_private_messages

message.rb:

    is_private_message

TODO: message controller include in engine (Possible?)
