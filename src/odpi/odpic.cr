@[Link("odpic")]
lib LibODPI

  # define ODPI-C version information
  DPI_MAJOR_VERSION = 4
  DPI_MINOR_VERSION = 4

  # define constants for success and failure of methods
  DPI_SUCCESS = 0
  DPI_FAILURE = -1

  DPI_MAX_ERROR_SIZE = 3072
  DPI_OCI_NLS_MAXBUFSZ = 100

  alias DpiOciNumber = UInt8

  #-----------------------------------------------------------------------------
  # Enumerations
  #-----------------------------------------------------------------------------

  # connection/pool authorization modes
  enum DpiAuthMode : UInt32
    Default = 0x00000000
    Sysdba  = 0x00000002
    Sysoper = 0x00000004
    Prelim  = 0x00000008
    Sysasm  = 0x00008000
    Sysbkp  = 0x00020000
    Sysdgd  = 0x00040000
    Syskmt  = 0x00080000
    Sysrac  = 0x00100000
  end

  # connection close modes
  enum DpiConnCloseMode : UInt32
    Default = 0x00
    Drop    = 0x01
    Retag   = 0x02
  end

  # connection/pool creation modes
  enum DpiCreateMode : UInt32
    Default     = 0x00
    Threaded    = 0x01
    Events      = 0x04
  end

  # dequeue modes for advanced queuing
  enum DpiDeqMode : UInt32
    Browse          = 1
    Locked          = 2
    Remove          = 3
    RemoveNoData    = 4
  end

  # dequeue navigation flags for advanced queuing
  enum DpiDeqNavigation : UInt32
    FirstMsg        = 1
    NextTransaction = 2
    NextMsg         = 3
  end

  # event types
  enum DpiEventType : UInt32
    None        = 0
    Startup     = 1
    Shutdown    = 2
    ShutdownAny = 3
    Dereg       = 5
    ObjChange   = 6
    QueryChange = 7
    Aq          = 100
  end

  # statement execution modes
  enum DpiExecMode : UInt32
    Default             = 0x00000000
    DescribeOnly        = 0x00000010
    CommitOnSuccess     = 0x00000020
    BatchErrors         = 0x00000080
    ParseOnly           = 0x00000100
    ArrayDmlRowcounts   = 0x00100000
  end

  # statement fetch modes
  enum DpiFetchMode : UInt16
    Next        = 0x02
    First       = 0x04
    Last        = 0x08
    Prior       = 0x10
    Absolute    = 0x20
    Relative    = 0x40
  end

  # message delivery modes in advanced queuing
  enum DpiMessageDeliveryMode : UInt16
    MsgPersistent           = 1
    MsgBuffered             = 2
    MsgPersistentOrBuffered = 3
  end

  # message states in advanced queuing
  enum DpiMessageState : UInt32
    Ready       = 0
    Waiting     = 1
    Processed   = 2
    Expired     = 3
  end

  # native C types
  enum DpiNativeTypeNum : UInt32
    Int64       = 3000
    Uint64      = 3001
    Float       = 3002
    Double      = 3003
    Bytes       = 3004
    Timestamp   = 3005
    IntervalDs  = 3006
    IntervalYm  = 3007
    Lob         = 3008
    Object      = 3009
    Stmt        = 3010
    Boolean     = 3011
    Rowid       = 3012
    Json        = 3013
    JsonObject  = 3014
    JsonArray   = 3015
    Null        = 3016
  end

  # operation codes (database change and continuous query notification)
  enum DpiOpCode : UInt32
    AllOps  = 0x00
    AllRows = 0x01
    Insert  = 0x02
    Update  = 0x04
    Delete  = 0x08
    Alter   = 0x10
    Drop    = 0x20
    Unknown = 0x40
  end

  # Oracle types
  enum DpiOracleTypeNum : UInt32
    None            = 2000
    Varchar         = 2001
    Nvarchar        = 2002
    Char            = 2003
    Nchar           = 2004
    Rowid           = 2005
    Raw             = 2006
    NativeFloat     = 2007
    NativeDouble    = 2008
    NativeInt       = 2009
    Number          = 2010
    Date            = 2011
    Timestamp       = 2012
    TimestampTz     = 2013
    TimestampLtz    = 2014
    IntervalDs      = 2015
    IntervalYm      = 2016
    Clob            = 2017
    Nclob           = 2018
    Blob            = 2019
    Bfile           = 2020
    Stmt            = 2021
    Boolean         = 2022
    Object          = 2023
    LongVarchar     = 2024
    LongRaw         = 2025
    NativeUint      = 2026
    Json            = 2027
    JsonObject      = 2028
    JsonArray       = 2029
    URowId          = 2030
    LongNvarchar    = 2031
    Max             = 2032
  end

  # session pool close modes
  enum DpiPoolCloseMode : UInt32
    Default = 0x00
    Force   = 0x01
  end

  # modes used when acquiring a connection from a session pool
  enum DpiPoolGetMode : UInt8
    Wait        = 0
    Nowait      = 1
    Forceget    = 2
    Timedwait   = 3
  end

  # purity values when acquiring a connection from a pool
  enum DpiPurity : UInt32
    Default = 0
    New     = 1
    Self    = 2
  end

  # database shutdown modes
  enum DpiShutdownMode : UInt32
    Default             = 0
    Transactional       = 1
    TransactionalLocal  = 2
    Immediate           = 3
    Abort               = 4
    Final               = 5
  end

  # SODA flags
  enum SodaFlags : UInt32
    Default         = 0x00
    AtomicCommit    = 0x01
    CreateCollMap   = 0x02
    IndexDropForce  = 0x04
  end

  # database startup modes
  enum DpiStartupMode : UInt32
    Default     = 0
    Force       = 1
    Restrict    = 2
  end

  # statement types
  enum DpiStatementType : UInt16
    Unknown     = 0
    Select      = 1
    Update      = 2
    Delete      = 3
    Insert      = 4
    Create      = 5
    Drop        = 6
    Alter       = 7
    Begin       = 8
    Declare     = 9
    Call        = 10
    ExplainPlan = 15
    Merge       = 16
    Rollback    = 17
    Commit      = 21
  end

  # subscription grouping classes
  enum DpiSubscrGroupingClass : UInt8
    Time    = 1
  end

  # subscription grouping types
  enum DpiSubscrGroupingType : UInt8
    Summary = 1
    Last    = 2
  end

  # subscription namespaces
  enum DpiSubscrNamespace : UInt32
    Aq          = 1
    Dbchange    = 2
  end

  # subscription protocols
  enum DpiSubscrProtocol : UInt32
    Callback    = 0
    Mail        = 1
    Plsql       = 2
    Http        = 3
  end

  # subscription quality of service
  enum DpiSubscrQos : UInt32
    Reliable    = 0x01
    DeregNfy    = 0x02
    Rowids      = 0x04
    Query       = 0x08
    BestEffort  = 0x10
  end

  # two-phase commit (flags for dpiConn_tpcBegin())
  enum DpiTpcBeginFlags : UInt32
    Join         = 0x02
    New          = 0x01
    Promote      = 0x08
    Resume       = 0x04
  end

  # two-phase commit (flags for dpiConn_tpcEnd())
  enum DpiTpcEndFlags : UInt32
    Normal         = 0
    Suspend        = 0x00100000
  end

  # visibility of messages in advanced queuing
  enum DpiVisibility : UInt32
    Immediate   = 1
    OnCommit    = 2
  end

  enum DpiErrorNum
    NoErr = 1000
    NoEemory
    InvalidHandle
    ErrNotInitialized
    GetFailed
    CreateEnv
    ConvertText
    QueryNotExecuted
    UnhandledDataType
    InvalidArrayPosition
    NotConnected
    ConnNotInPool
    InvalidProxy
    NotSupported
    UnhandledConversion
    ArraySizeTooBig
    InvalidDate
    ValueIsNull
    ArraySizeTooSmall
    BufferSizeTooSmall
    VersionNotSupported
    InvalidOracleType
    WrongAttr
    NotCollection
    InvalidIndex
    NoObjectType
    InvalidCharset
    ScrollOutOfRs
    QueryPositionInvalid
    NoRowFetched
    TlsError
    ArraySizeZero
    ExtAuthWithCredentials
    CannotGetRowOffset
    ConnIsExternal
    TransIdTooLarge
    BranchIdTooLarge
    ColumnFetch
    StmtClosed
    LobClosed
    InvalidCharsetId
    InvalidOciNumber
    InvalidNumber
    NumberNoRepr
    NumberStringTooLong
    NullPointerParameter
    LoadLibrary
    LoadSymbol
    OracleClientTooOld
    NlsEnvVarGet
    PtrLengthMismatch
    Nan
    WrongType
    BufferSizeTooLarge
    NoEditionWithConnClass
    No_BindVarsInDdl
    SubscrClosed
    NoEditionWithNewPassword
    UnexpectedOciReturnValue
    ExecModeOnlyForDml
    ArrayVarNotSupported
    EventsModeRequired
    OracleDbTooOld
    CallTimeout
    SodaCursorClosed
    ExtAuthInvalidProxy
    QueueNoPayload
    QueueWrongPayloadType
    OracleClientUnsupported
    MissingShardingKey
    Max
  end

  #-----------------------------------------------------------------------------
  # Handle Types
  #-----------------------------------------------------------------------------
  type DpiConn = Void
  type DpiContext = Void
  type DpiDeqOptions = Void
  type DpiEnqOptions = Void
  type DpiJson = Void
  type DpiMsgProps = Void
  type DpiObjectAttr = Void
  type DpiPool = Void
  type DpiQueue = Void
  type DpiSodaColl = Void
  type DpiSodaCollCursor = Void
  type DpiSodaDb = Void
  type DpiSodaDoc = Void
  type DpiSodaDocCursor = Void
  type DpiStmt = Void
  type DpiSubscr = Void
  type DpiVar = Void

  #-----------------------------------------------------------------------------
  # Forward Declarations of Other Types
  #-----------------------------------------------------------------------------

  type DpiJsonNode = Void
  type DpiObjectAttrInfo = Void
  type DpiObjectTypeInfo = Void
  type DpiPoolCreateParams = Void
  type DpiSodaCollNames = Void
  type DpiSodaOperOptions = Void
  type DpiSubscrCreateParams = Void
  type DpiSubscrMessage = Void
  type DpiSubscrMessageQuery = Void
  type DpiSubscrMessageRow = Void
  type DpiSubscrMessageTable = Void
  type DpiVersionInfo = Void
  type DpiXid = Void
  type DpiEnv = Void
  type DpiTypeFreeProc = Void*

  type UserName = UInt8*

  #-----------------------------------------------------------------------------
  # Complex Native Data Types (used for transferring data to/from ODPI-C)
  #-----------------------------------------------------------------------------

  # structure used for transferring byte strings to/from ODPI-C
  struct DpiBytes
    ptr : UInt8*
    length : UInt32
    encoding : UInt8*
  end

  # structure used for transferring day/seconds intervals to/from ODPI-C
  struct DpiIntervalDs
    days : Int32
    hours : Int32
    minutes : Int32
    seconds : Int32
    fseconds : Int32
  end

  # structure used for transferring years/months intervals to/from ODPI-C
  struct DpiIntervalYm
    years : Int32
    months : Int32
  end

  # structure used for transferring JSON nodes to/from ODPI-C
  struct DpiJsonArray
    numElements : Int32
    elements : DpiJsonNode*
    elementValues : DpiDataBuffer*
  end

  # structure used for transferring dates to/from ODPI-C
  struct DpiTimestamp
    year : Int16
    month : UInt8
    day : UInt8
    hour : UInt8
    minute : UInt8
    second : UInt8
    fsecond : UInt32
    tzHourOffset : Int8
    tzMinuteOffset : Int8
  end

  #-----------------------------------------------------------------------------
  # Other Types
  #-----------------------------------------------------------------------------

  # union used for providing a buffer of any data type
  union DpiDataBuffer
    asBoolean : Int32
    asInt64 : Int64
    asUint64 : UInt64
    asFloat : Float32
    asDouble : Float64
    asBytes : DpiBytes
    asTimestamp : DpiTimestamp
    asIntervalDs : DpiIntervalDs
    asIntervalYm : DpiIntervalYm
    asLOB : DpiLob*
    asObject : DpiObject*
    asStmt : DpiStmt*
    asRowid : DpiRowid*
  end

  # structure used for application context
  struct DpiAppContext
    namespaceName : UInt8*
    namespaceNameLength : UInt32
    name : UInt8*
    nameLength : UInt32
    value : UInt8*
    valueLength : UInt32
  end

  # structure used for common parameters used for creating standalone
  # connections and session pools
  struct DpiCommonCreateParams
    createMode : DpiCreateMode
    encoding : UInt8*
    nencoding : UInt8*
    edition : UInt8*
    editionLength : UInt32
    driverName : UInt8*
    driverNameLength : UInt32
    sodaMetadataCache : Int8
    stmtCacheSize : UInt32
  end

  # structure used for creating connections
  struct DpiConnCreateParams
      authMode : DpiAuthMode
      connectionClass : UInt8*
      connectionClassLength : UInt32
      purity : DpiPurity
      newPassword : UInt8*
      newPasswordLength : UInt32
      appContext : DpiAppContext*
      numAppContext : UInt32
      externalAuth : Int8
      externalHandle : Void*
      pool : DpiPool*
      tag : UInt32
      tagLength : UInt32
      matchAnyTag : Int8
      outTag : UInt8*
      outTagLength : UInt32
      outTagFound : Int8
      shardingKeyColumns : DpiShardingKeyColumn*
      numShardingKeyColumns : UInt8
      superShardingKeyColumns : DpiShardingKeyColumn*
      numSuperShardingKeyColumns : UInt8
      outNewSession : Int8
  end

  # structure used for creating connections
  struct DpiContextCreateParams
    defaultDriverName : UInt8*
    defaultEncoding : UInt8*
    loadErrorUrl : UInt8*
    oracleClientLibDir : UInt8*
    oracleClientConfigDir : UInt8*
  end

  # structure used for transferring data to/from ODPI-C
  struct DpiData
    isNull : Int32
    value : DpiDataBuffer
  end

  #structure used for providing metadata about data types
  struct DpiDataTypeInfo
    oracleTypeNum : DpiOracleTypeNum
    defaultNativeTypeNum : DpiNativeTypeNum
    ociTypeCode : UInt16
    dbSizeInBytes : UInt32
    clientSizeInBytes : UInt32
    sizeInChars : UInt32
    precision : Int16
    scale : Int8
    fsPrecision : UInt8
    objectType : DpiObjectType*
  end

  # structure used for transferring encoding information from ODPI-C
  struct DpiEncodingInfo
      encoding : UInt8*
      maxBytesPerCharacter : UInt32
      nencoding : UInt8*
      nmaxBytesPerCharacter : UInt32
  end

  # structure used for transferring error information from ODPI-C
  struct DpiErrorInfo
    code : Int32
    offset : UInt16
    message : UInt8*
    messageLength : UInt32
    encoding : UInt8*
    fnName : UInt8*
    action : UInt8*
    sqlState : UInt8*
    isRecoverable : Int32
  end

  # structure used for transferring query metadata from ODPI-C
  struct DpiQueryInfo
    name : UInt8*
    nameLength : UInt32
    typeInfo : DpiDataTypeInfo
    nullOk : Int32
  end

  # structure used for sharding key columns
  struct DpiShardingKeyColumn
      oracleTypeNum : DpiOracleTypeNum
      nativeTypeNum : DpiNativeTypeNum
      value : DpiDataBuffer
  end

  # structure used for transferring statement information from ODPI-C
  struct DpiStmtInfo
      isQuery : Int8
      isPLSQL : Int8
      isDDL : Int8
      isDML : Int8
      statementType : DpiStatementType
      isReturning : Int8
  end

  union DpiReferenceBuffer
    asHandle : Void*
    asObject : DpiObject*
    asStmt : DpiStmt*
    asLOB : DpiLob*
    asRowid : DpiRowid*
  end

  union DpiOracleData
    asRaw : Void*
    asBytes : UInt8*
    asFloat : Float32*
    asDouble : Float64*
    asInt32 : Int32*
    asInt64 : Int64*
    asUint64 : UInt64*
    asNumber : DpiOciNumber*
    asDate : DpiOciDate*
    asTimestamp : Void**
    asInterval : Void**
    asLobLocator : Void**
    asString : Void**
    asRawData : Void**
    asStmt : Void**
    asRowid : Void**
    asBoolean : Int32*
    asObject : Void**
    asCollection : Void**
  end

  struct DpiLob
    typeDef : DpiTypeDef*
    checkInt : UInt32
    refCount : UInt32
    env : DpiEnv*
    conn : DpiConn*
    openSlotNum : UInt32
    type : DpiOracleType*
    locator : Void*
    buffer : UInt8*
    closing : Int32
  end

  struct DpiOracleType
    oracleTypeNum : DpiOracleTypeNum
    defaultNativeTypeNum : DpiNativeTypeNum
    oracleType : UInt16
    charsetForm : UInt8
    sizeInBytes : UInt32
    isCharacterData : Int32
    canBeInArray : Int32
    requiresPreFetch : Int32
  end

  struct DpiObjectType
    typeDef : DpiTypeDef*
    checkInt : UInt32
    refCount : UInt32
    env : DpiEnv*
    conn : DpiConn*
    tdo : Void*
    typeCode : UInt16
    schema : UInt8*
    schemaLength : UInt32
    name : UInt8*
    nameLength : UInt32
    elementTypeInfo : DpiDataTypeInfo
    isCollection : Int32
    numAttributes : UInt16
  end

  struct DpiObject
    typeDef : DpiTypeDef*
    checkInt : UInt32
    refCount : UInt32
    env : DpiEnv*
    type : DpiObjectType*
    openSlotNum : UInt32
    instance : Void*
    indicator : Void*
    dependsOnObj : DpiObject*
    freeIndicator : Int32
    closing : Int32
  end

  struct DpiRowid
    typeDef : DpiTypeDef*
    checkInt : UInt32
    refCount : UInt32
    env : DpiEnv*
    handle : Void*
    buffer : UInt8*
    bufferLengt : UInt16
  end

  struct DpiTypeDef
    name : UInt8*
    size : LibC::SizeT
    checkInt : UInt32
    freeProc : DpiTypeFreeProc
  end

  struct DpiError
    buffer : DpiErrorBuffer*
    handle : Void*
    env : DpiEnv*
  end

  struct DpiErrorBuffer
    code : Int32
    offset : UInt32
    errorNum : DpiErrorNum
    fnName : UInt8*
    action : UInt8*
    encoding : StaticArray(UInt8, DPI_OCI_NLS_MAXBUFSZ)
    message : StaticArray(UInt8, DPI_MAX_ERROR_SIZE)
    messageLength : UInt32
    isRecoverable : Int32
    isWarning : Int32
  end

  struct DpiOciDate
    year : Int16
    month : UInt8
    day : UInt8
    hour : UInt8
    minute : UInt8
    second : UInt8
  end

  #-----------------------------------------------------------------------------
  # Context Methods (dpiContext)
  #-----------------------------------------------------------------------------

  # create a context handle and validate the version information (with params)
  fun dpi_context_create_with_params = dpiContext_createWithParams(majorVersion : UInt32,
                                                                   minorVersion : UInt32,
                                                                   params : DpiContextCreateParams*,
                                                                   context : DpiContext**,
                                                                   errorInfo : DpiErrorInfo*) : Int32

  # destroy context handle
  fun dpi_context_destroy = dpiContext_destroy(context : DpiContext*) : Int32

  # get error information
  fun dpi_context_get_error = dpiContext_getError(context : DpiContext*,
                                                  errorInfo : DpiErrorInfo*) : Void

  # initialize context parameters to default values
  fun dpi_context_init_common_create_params = dpiContext_initCommonCreateParams(context : DpiContext*,
                                                                                params : DpiCommonCreateParams *) : Int32

  # initialize connection create parameters to default values
  fun dpi_context_init_conn_create_params = dpiContext_initConnCreateParams(context : DpiContext*,
                                                                            params : DpiConnCreateParams*) : Int32

  #-----------------------------------------------------------------------------
  # Connection Methods (dpiConn)
  #-----------------------------------------------------------------------------

  # close the connection now, not when the reference count reaches zero
  fun dpi_conn_close = dpiConn_close(conn : DpiConn*,
                                     mode : DpiConnCloseMode,
                                     tag : UInt8*,
                                     tag_length : UInt32) : Int32

  # commits the current active transaction
  fun dpi_conn_commit = dpiConn_commit(conn : DpiConn *) : Int32

  # create a connection and return a reference to it
  fun dpi_conn_create = dpiConn_create(context : DpiContext*,
                                       user_name : UserName*,
                                       user_name_length : UInt32,
                                       password : UInt8*,
                                       password_length : UInt32,
                                       connect_string : UInt8*,
                                       connect_string_length : UInt32,
                                       common_params : DpiCommonCreateParams*,
                                       createParams : DpiConnCreateParams*,
                                       conn : DpiConn**) : Int32

  # prepare a statement and return it for subsequent execution/fetching
  fun dpi_conn_prepare_stmt = dpiConn_prepareStmt(conn : DpiConn*,
                                                  scrollable : Int32,
                                                  sql : UInt8*,
                                                  sqlLength : UInt32,
                                                  tag : UInt8*,
                                                  tagLength : UInt32,
                                                  stmt : DpiStmt**) : Int32

  # release a reference to the connection
  fun dpi_conn_release = dpiConn_release(conn : DpiConn*) : Int32

  #-----------------------------------------------------------------------------
  # Statement Methods (dpiStmt)
  #-----------------------------------------------------------------------------

  # bind a value to the statement using the given name
  # this creates the variable by looking at the type and then binds it
  fun dpi_stmt_bind_value_by_name = dpiStmt_bindValueByName(stmt : DpiStmt*,
                                                            name : UInt8*,
                                                            nameLength : UInt32,
                                                            nativeTypeNum : DpiNativeTypeNum,
                                                            data : DpiData*)

  # bind a value to the statement at the given position
  # this creates the variable by looking at the type and then binds it
  fun dpi_stmt_bind_value_by_pos = dpiStmt_bindValueByPos(stmt : DpiStmt*,
                                                          pos : UInt32,
                                                          nativeTypeNum : DpiNativeTypeNum,
                                                          data : DpiData*) : Int32

  fun dpi_stmt_execute = dpiStmt_execute(stmt : DpiStmt*,
                                         mode : DpiExecMode,
                                         numQueryColumns : UInt32*) : Int32

  fun dpi_stmt_execute_many = dpiStmt_executeMany(stmt : DpiStmt*,
                                                  mode : DpiExecMode,
                                                  numIters : UInt32)

  fun dpi_stmt_fetch = dpiStmt_fetch(stmt : DpiStmt*,
                                     found : Int32*,
                                     bufferRowIndex : UInt32*) : Int32

  fun dpi_stmt_fetch_rows = dpiStmt_fetchRows(stmt : DpiStmt*,
                                              maxRows : UInt32,
                                              bufferRowIndex : UInt32*,
                                              numRowsFetched : UInt32*,
                                              moreRows : Int32*) : Int32

  fun dpi_stmt_get_query_info = dpiStmt_getQueryInfo(stmt : DpiStmt*,
                                                     pos : UInt32,
                                                     info :  DpiQueryInfo*) : Int32

  fun dpi_stmt_get_query_value = dpiStmt_getQueryValue(stmt : DpiStmt*,
                                                       pos : UInt32,
                                                       nativeTypeNum : DpiNativeTypeNum*,
                                                       data : DpiData**) : Int32

  fun dpi_stmt_get_row_count = dpiStmt_getRowCount(stmt: DpiStmt*,
                                                   count: UInt64*) : Int32

  fun dpi_stmt_release = dpiStmt_release(stmt : DpiStmt*)
end
