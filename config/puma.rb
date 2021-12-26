# frozen_string_literal: true
require "barnes"
require "fileutils"

DEVELOPMENT = "development"
PRODUCTION = "production"
RAILS_ENV = ENV.fetch("RAILS_ENV", DEVELOPMENT)
PORT = ENV.fetch("PORT", 3000)
PIDS_DIR = "tmp/pids"

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 1)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
workers ENV.fetch("WEB_CONCURRENCY", 0).to_i
environment RAILS_ENV
pidfile(
  ENV.fetch("PIDFILE") do
    FileUtils.mkdir_p(PIDS_DIR)
    "#{PIDS_DIR}/server.pid"
  end
)
plugin :tmp_restart
before_fork { Barnes.start }

port PORT if RAILS_ENV == PRODUCTION

if RAILS_ENV == DEVELOPMENT
  ssl_bind(
    "0.0.0.0",
    PORT,
    {
      key: "#{Dir.home}/.localhost/localhost.key",
      cert: "#{Dir.home}/.localhost/localhost.crt"
    }
  )
end
