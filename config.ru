# frozen_string_literal: true

require_relative 'app'

use Rack::MethodOverride

run BookmarkManager
