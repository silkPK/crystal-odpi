module ODPI
  class Statement < DB::Statement
    @raw_stmt : ODPI::DpiStmt*
    @query : Bytes
    @num_cols : UInt32?
    getter raw_stmt

    def initialize(connection, query : String)
      super(connection)
      @raw_stmt = Pointer(ODPI::DpiStmt).null
      @query = query.to_slice()
    end

    protected def raw_conn
      @connection.as(Connection).raw_conn
    end

    protected def perform_query(args : Enumerable) : ODPI::ResultSet
      null = Pointer(Void).null
      conn = raw_conn()
      res = ODPI.dpi_conn_prepare_stmt(conn, 0, @query, @query.size,
                                       Pointer(UInt8).null, 0,
                                       out @raw_stmt)

      if res != ODPI::DPI_SUCCESS
        raise "Error preparing statement"
      end

      if args.size != 0
        Binder.bind_args(self, args)
      end

      res = ODPI.dpi_stmt_execute(@raw_stmt , ODPI::DpiExecMode::Default, out num_cols)

      if res != ODPI::DPI_SUCCESS
        error_info = ODPI::DpiErrorInfo.new
        ODPI.dpi_context_get_error(connection.raw_context, pointerof(error_info))
        error_msg = String.new(error_info.message)
        raise "Error executing statement #{error_msg}"
      end

      ResultSet.new(self, num_cols)
    end

    protected def perform_exec(args : Enumerable) : DB::ExecResult
      result = perform_query(args)
      result.each { }
      DB::ExecResult.new(rows_affected: result.rows_affected, last_insert_id: 0_i64)
    end

    protected def do_close
      super

      ODPI.dpi_stmt_release(@raw_stmt)
    end
  end
end
