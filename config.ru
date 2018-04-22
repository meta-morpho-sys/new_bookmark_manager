# frozen_string_literal: true

require_relative 'app'

#
ENV['SESSION_SECRET'] = 'WC1BoCWzHAzsB962ZLXVfNg6SOc='

use Rack::MethodOverride

run BookmarkManager
