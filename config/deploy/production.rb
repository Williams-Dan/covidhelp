# frozen_string_literal: true

server ENV['HOST'], user: 'deploy', roles: %w[app db web]
