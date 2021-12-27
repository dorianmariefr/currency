# frozen_string_literal: true
FriendlyId.defaults do |config|
  config.use :finders
  config.use :slugged
end
