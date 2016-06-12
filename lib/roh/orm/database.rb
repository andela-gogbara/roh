require "sqlite3"

module Roh
  class Database
    def self.connect
      SQLite3::Database.new(File.join APP_ROOT, "db", "app.db")
    end
  end
end
