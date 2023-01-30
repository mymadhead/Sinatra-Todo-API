# frozen_string_literal: true

configure :production, :development do
  set :show_exceptions, true

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://127.0.0.1/todo')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..],
    encoding: 'utf8'
  )
end

ActiveRecord::Base.class_eval do
  def self.reset_autoincrement(options = {})
    options[:to] ||= 1
    case connection.adapter_name
    when 'MySQL'
      connection.execute "ALTER TABLE #{table_name} AUTO_INCREMENT=#{options[:to]}"
    when 'PostgreSQL'
      connection.execute "ALTER SEQUENCE #{table_name}_id_seq RESTART WITH #{options[:to]};"
    when 'SQLite'
      connection.execute "UPDATE sqlite_sequence SET seq=#{options[:to]} WHERE name='#{table_name}';"
    end
  end
end
