# frozen_string_literal: true

module Constants
  # Common
  APP_ROOT              = ENV.fetch('APP_ROOT')
  # OpenTelemetry
  APPLICATION_NAME      = ENV.fetch('APPLICATION_NAME')
  APPLICATION_VERSION   = ENV.fetch('APPLICATION_VERSION')
  # Redis
  REDIS_URL             = ENV.fetch('REDIS_URL')
end
