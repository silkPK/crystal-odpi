require "spec"
require "../src/odpi"

include ODPI

DB_URL = ENV["DATABASE_URL"]? || "odpi:///"

def with_db(&block : DB::Database ->)
  DB.open "#{DB_URL}", &block
end

def with_cnn(&block : DB::Connection ->)
  DB.connect "#{DB_URL}", &block
end

