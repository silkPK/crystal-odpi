module ODPI
  class Connection < DB::Connection
    @raw_conn : ODPI::DpiConn*
    @raw_context : ODPI::DpiContext*
    @details : String?
    getter raw_conn, raw_context

    def initialize(context : DB::ConnectionContext)
      super(context)
      @raw_conn = Pointer(ODPI::DpiConn).null
      @raw_context = Pointer(ODPI::DpiContext).null

      error = ODPI::DpiErrorInfo.new

      res = ODPI.dpi_context_create_with_params(ODPI::DPI_MAJOR_VERSION,ODPI::DPI_MINOR_VERSION,nil, pointerof(@raw_context), pointerof(error))

      if res != ODPI::DPI_SUCCESS
        puts String.new(error.message)
      end

      user = context.uri.user.not_nil!.to_slice()
      user_len = user.size
      user = user.to_unsafe.as(Pointer(ODPI::UserName))

      password = context.uri.password.not_nil!.to_slice
      conn_string =
        if context.uri.port != nil
          "#{context.uri.host}:#{context.uri.port}#{context.uri.path}".to_slice
        else
          "#{context.uri.host}#{context.uri.path}".to_slice
        end

      common_params = Pointer(ODPI::DpiCommonCreateParams).null
      create_params = Pointer(ODPI::DpiConnCreateParams).null

      # connect to the database
      res = ODPI.dpi_context_init_conn_create_params(@raw_context, create_params)

      if res != ODPI::DPI_FAILURE
        ODPI.dpi_context_get_error(@raw_context,pointerof(error))
        puts String.new(error.message)
      end

      res = ODPI.dpi_conn_create(@raw_context, user, user_len, password,
                                 password.size, conn_string, conn_string.size,
                                 common_params, create_params, pointerof(@raw_conn))

      if res != ODPI::DPI_SUCCESS
        ODPI.dpi_context_get_error(@raw_context, pointerof(error))
        error_msg = String.new(error.message)
        raise "Error establishing connection: #{error_msg}"
      end
    end

    def build_prepared_statement(query) : Statement
      Statement.new(self, query)
    end

    def build_unprepared_statement(query) : Statement
      Statement.new(self, query)
    end

    def do_close
      super
      res = ODPI.dpi_conn_release(@raw_conn)
      res = ODPI.dpi_context_destroy(@raw_context)
    end
  end
end
