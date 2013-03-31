# coding: utf-8
module PrivateMessages
  class Engine < ::Rails::Engine
    isolate_namespace PrivateMessages
    engine_name "private_messages"

    initializer "private_messages.includers" do |app|
      # TODO: вынести контроллеры в engine
      # ActionController::Base.send :include, DeviseRussian::Controllers::Base
      ActiveRecord::Base.send :include, PrivateMessages::Models::PrivateUser
      ActiveRecord::Base.send :include, PrivateMessages::Models::PrivateMessage
    end
  end
end
