module ODPI
  module Binder
    extend self

    def bind_args(stmt : Statement, args : Enumerable)

      args.each_with_index do |arg, i|
        data = arg_as_dpi_data(typeof(arg), arg)
        native_type = Type.as_native_type_num(typeof(arg))

        res = LibODPI.dpi_stmt_bind_value_by_pos(stmt.raw_stmt, i + 1, native_type,
                                              pointerof(data))
        if res != LibODPI::DPI_SUCCESS
          error_info = LibODPI::DpiErrorInfo.new
          LibODPI.dpi_context_get_error(stmt.connection.raw_context,
                                     pointerof(error_info))
          error_msg = String.new(error_info.message)
          raise "Error binding arguments by position: #{error_msg}"
        end
      end
    end

    private def arg_as_dpi_data(t : Int32.class, arg)
      arg_as_dpi_data(Int64, arg)
    end

    private def arg_as_dpi_data(t : Int64.class, arg)
      buffer = LibODPI::DpiData.new

      buffer.isNull = 0
      buffer.value.asInt64 = arg

      buffer
    end

    private def arg_as_dpi_data(t : UInt32.class, arg)
      arg_as_dpi_data(UInt64, arg)
    end

    private def arg_as_dpi_data(t : UInt64.class, arg)
      buffer = LibODPI::DpiData.new

      buffer.isNull = 0
      buffer.value.asUint64 = arg

      buffer
    end

    private def arg_as_dpi_data(t : Float32.class, arg)
      buffer = LibODPI::DpiData.new

      buffer.isNull = 0
      buffer.value.asFloat = arg

      buffer
    end

    private def arg_as_dpi_data(t : Float64.class, arg)
      buffer = LibODPI::DpiData.new

      buffer.isNull = 0
      buffer.value.asDouble = arg

      buffer
    end

    private def arg_as_dpi_data(t : Bool.class, arg)
      buffer = LibODPI::DpiData.new

      buffer.isNull = 0
      if arg
        buffer.value.asBoolean = 1
      else
        buffer.value.asBoolean = 0
      end

      buffer
    end

    private def arg_as_dpi_data(t : Time.class, arg)
      buffer = LibODPI::DpiData.new
      # TODO
    end

    private def arg_as_dpi_data(t : String.class, arg)
      buffer = LibODPI::DpiData.new

      arg.check_no_null_byte

      buffer.isNull = 0
      buffer.value.asBytes.ptr = arg.to_unsafe
      buffer.value.asBytes.length = arg.size

      buffer
    end
  end
end
