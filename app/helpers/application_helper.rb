# frozen_string_literal: true

module ApplicationHelper
  include Heroicon::Engine.helpers

  def title(string = nil, &block)
    content_for(:title, string || capture(&block))
  end
end
