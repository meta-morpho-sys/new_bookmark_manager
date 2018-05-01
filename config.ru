# frozen_string_literal: true

Bundler.require(:default)

require_relative 'app'

use Rack::MethodOverride

run BookmarkManager
