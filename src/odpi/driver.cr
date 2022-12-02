class ODPI::Driver < DB::Driver
  def build_connection(context : DB::ConnectionContext) : ODPI::Connection
    ODPI::Connection.new(context)
  end
end

DB.register_driver "odpi", ODPI::Driver
