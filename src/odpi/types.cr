module ODPI
  module Type
    extend self

    def as_oracle_type_num(t : Int32.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : Int64.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : UInt32.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : UInt64.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : Float32.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : Float64.class)
      LibODPI::DpiOracleTypeNum::Number
    end

    def as_oracle_type_num(t : Bool.class)
      LibODPI::DpiOracleTypeNum::Boolean
    end

    def as_oracle_type_num(t : Time.class, pattern : String = "%Y-%m-%d %H:%M:%S.%N")
      # TODO
      LibODPI::DpiOracleTypeNum::Date
    end

    def as_oracle_type_num(t : String.class)
      LibODPI::DpiOracleTypeNum::Nvarchar
    end

    def as_native_type_num(t : Int32.class)
      LibODPI::DpiNativeTypeNum::Int64
    end

    def as_native_type_num(t : Int64.class)
      LibODPI::DpiNativeTypeNum::Int64
    end

    def as_native_type_num(t : UInt32.class)
      LibODPI::DpiNativeTypeNum::Uint64
    end

    def as_native_type_num(t : UInt64.class)
      LibODPI::DpiNativeTypeNum::Uint64
    end

    def as_native_type_num(t : Float32.class)
      LibODPI::DpiNativeTypeNum::Float
    end

    def as_native_type_num(t : Float64.class)
      LibODPI::DpiNativeTypeNum::Double
    end

    def as_native_type_num(t : Bool.class)
      LibODPI::DpiNativeTypeNum::Boolean
    end

    def as_native_type_num(t : Time.class, pattern : String = "%Y-%m-%d %H:%M:%S.%N")
      LibODPI::DpiNativeTypeNum::Timestamp
    end

    def as_native_type_num(t : String.class)
      LibODPI::DpiNativeTypeNum::Bytes
    end

    def as_native_type_num(t : NoReturn.class)
      LibODPI::DpiNativeTypeNum::Null
    end
  end
end
