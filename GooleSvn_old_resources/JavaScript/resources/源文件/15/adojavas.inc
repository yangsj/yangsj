<%
//--------------------------------------------------------------------
// Microsoft ADO
//
// Copyright (c) 1996-1998 Microsoft Corporation.
//
//
//
// ADO constants include file for JavaScript
//
//--------------------------------------------------------------------

//---- CursorTypeEnum Values ----
var adOpenForwardOnly = 0;
var adOpenKeyset = 1;
var adOpenDynamic = 2;
var adOpenStatic = 3;

//---- CursorOptionEnum Values ----
var adHoldRecords = 0x00000100;
var adMovePrevious = 0x00000200;
var adAddNew = 0x01000400;
var adDelete = 0x01000800;
var adUpdate = 0x01008000;
var adBookmark = 0x00002000;
var adApproxPosition = 0x00004000;
var adUpdateBatch = 0x00010000;
var adResync = 0x00020000;
var adNotify = 0x00040000;
var adFind = 0x00080000;
var adSeek = 0x00400000;
var adIndex = 0x00800000;

//---- LockTypeEnum Values ----
var adLockReadOnly = 1;
var adLockPessimistic = 2;
var adLockOptimistic = 3;
var adLockBatchOptimistic = 4;

//---- ExecuteOptionEnum Values ----
var adAsyncExecute = 0x00000010;
var adAsyncFetch = 0x00000020;
var adAsyncFetchNonBlocking = 0x00000040;
var adExecuteNoRecords = 0x00000080;
var adExecuteStream = 0x00000400;

//---- ConnectOptionEnum Values ----
var adAsyncConnect = 0x00000010;

//---- ObjectStateEnum Values ----
var adStateClosed = 0x00000000;
var adStateOpen = 0x00000001;
var adStateConnecting = 0x00000002;
var adStateExecuting = 0x00000004;
var adStateFetching = 0x00000008;

//---- CursorLocationEnum Values ----
var adUseServer = 2;
var adUseClient = 3;

//---- DataTypeEnum Values ----
var adEmpty = 0;
var adTinyInt = 16;
var adSmallInt = 2;
var adInteger = 3;
var adBigInt = 20;
var adUnsignedTinyInt = 17;
var adUnsignedSmallInt = 18;
var adUnsignedInt = 19;
var adUnsignedBigInt = 21;
var adSingle = 4;
var adDouble = 5;
var adCurrency = 6;
var adDecimal = 14;
var adNumeric = 131;
var adBoolean = 11;
var adError = 10;
var adUserDefined = 132;
var adVariant = 12;
var adIDispatch = 9;
var adIUnknown = 13;
var adGUID = 72;
var adDate = 7;
var adDBDate = 133;
var adDBTime = 134;
var adDBTimeStamp = 135;
var adBSTR = 8;
var adChar = 129;
var adVarChar = 200;
var adLongVarChar = 201;
var adWChar = 130;
var adVarWChar = 202;
var adLongVarWChar = 203;
var adBinary = 128;
var adVarBinary = 204;
var adLongVarBinary = 205;
var adChapter = 136;
var adFileTime = 64;
var adPropVariant = 138;
var adVarNumeric = 139;
var adArray = 0x2000;

//---- FieldAttributeEnum Values ----
var adFldMayDefer = 0x00000002;
var adFldUpdatable = 0x00000004;
var adFldUnknownUpdatable = 0x00000008;
var adFldFixed = 0x00000010;
var adFldIsNullable = 0x00000020;
var adFldMayBeNull = 0x00000040;
var adFldLong = 0x00000080;
var adFldRowID = 0x00000100;
var adFldRowVersion = 0x00000200;
var adFldCacheDeferred = 0x00001000;
var adFldIsChapter = 0x00002000;
var adFldNegativeScale = 0x00004000;
var adFldKeyColumn = 0x00008000;
var adFldIsRowURL = 0x00010000;
var adFldIsDefaultStream = 0x00020000;
var adFldIsCollection = 0x00040000;

//---- EditModeEnum Values ----
var adEditNone = 0x0000;
var adEditInProgress = 0x0001;
var adEditAdd = 0x0002;
var adEditDelete = 0x0004;

//---- RecordStatusEnum Values ----
var adRecOK = 0x0000000;
var adRecNew = 0x0000001;
var adRecModified = 0x0000002;
var adRecDeleted = 0x0000004;
var adRecUnmodified = 0x0000008;
var adRecInvalid = 0x0000010;
var adRecMultipleChanges = 0x0000040;
var adRecPendingChanges = 0x0000080;
var adRecCanceled = 0x0000100;
var adRecCantRelease = 0x0000400;
var adRecConcurrencyViolation = 0x0000800;
var adRecIntegrityViolation = 0x0001000;
var adRecMaxChangesExceeded = 0x0002000;
var adRecObjectOpen = 0x0004000;
var adRecOutOfMemory = 0x0008000;
var adRecPermissionDenied = 0x0010000;
var adRecSchemaViolation = 0x0020000;
var adRecDBDeleted = 0x0040000;

//---- GetRowsOptionEnum Values ----
var adGetRowsRest = -1;

//---- PositionEnum Values ----
var adPosUnknown = -1;
var adPosBOF = -2;
var adPosEOF = -3;

//---- BookmarkEnum Values ----
var adBookmarkCurrent = 0;
var adBookmarkFirst = 1;
var adBookmarkLast = 2;

//---- MarshalOptionsEnum Values ----
var adMarshalAll = 0;
var adMarshalModifiedOnly = 1;

//---- AffectEnum Values ----
var adAffectCurrent = 1;
var adAffectGroup = 2;
var adAffectAllChapters = 4;

//---- ResyncEnum Values ----
var adResyncUnderlyingValues = 1;
var adResyncAllValues = 2;

//---- CompareEnum Values ----
var adCompareLessThan = 0;
var adCompareEqual = 1;
var adCompareGreaterThan = 2;
var adCompareNotEqual = 3;
var adCompareNotComparable = 4;

//---- FilterGroupEnum Values ----
var adFilterNone = 0;
var adFilterPendingRecords = 1;
var adFilterAffectedRecords = 2;
var adFilterFetchedRecords = 3;
var adFilterConflictingRecords = 5;

//---- SearchDirectionEnum Values ----
var adSearchForward = 1;
var adSearchBackward = -1;

//---- PersistFormatEnum Values ----
var adPersistADTG = 0;
var adPersistXML = 1;

//---- StringFormatEnum Values ----
var adClipString = 2;

//---- ConnectPromptEnum Values ----
var adPromptAlways = 1;
var adPromptComplete = 2;
var adPromptCompleteRequired = 3;
var adPromptNever = 4;

//---- ConnectModeEnum Values ----
var adModeUnknown = 0;
var adModeRead = 1;
var adModeWrite = 2;
var adModeReadWrite = 3;
var adModeShareDenyRead = 4;
var adModeShareDenyWrite = 8;
var adModeShareExclusive = 0xc;
var adModeShareDenyNone = 0x10;
var adModeRecursive = 0x400000;

//---- RecordCreateOptionsEnum Values ----
var adCreateCollection = 0x00002000;
var adCreateStructDoc = 0x80000000;
var adCreateNonCollection = 0x00000000;
var adOpenIfExists = 0x02000000;
var adCreateOverwrite = 0x04000000;
var adFailIfNotExists = -1;

//---- RecordOpenOptionsEnum Values ----
var adOpenRecordUnspecified = -1;
var adOpenOutput = 0x00800000;
var adOpenAsync = 0x00001000;
var adDelayFetchStream = 0x00004000;
var adDelayFetchFields = 0x00008000;
var adOpenExecuteCommand = 0x00010000;

//---- IsolationLevelEnum Values ----
var adXactUnspecified = 0xffffffff;
var adXactChaos = 0x00000010;
var adXactReadUncommitted = 0x00000100;
var adXactBrowse = 0x00000100;
var adXactCursorStability = 0x00001000;
var adXactReadCommitted = 0x00001000;
var adXactRepeatableRead = 0x00010000;
var adXactSerializable = 0x00100000;
var adXactIsolated = 0x00100000;

//---- XactAttributeEnum Values ----
var adXactCommitRetaining = 0x00020000;
var adXactAbortRetaining = 0x00040000;

//---- PropertyAttributesEnum Values ----
var adPropNotSupported = 0x0000;
var adPropRequired = 0x0001;
var adPropOptional = 0x0002;
var adPropRead = 0x0200;
var adPropWrite = 0x0400;

//---- ErrorValueEnum Values ----
var adErrProviderFailed = 0xbb8;
var adErrInvalidArgument = 0xbb9;
var adErrOpeningFile = 0xbba;
var adErrReadFile = 0xbbb;
var adErrWriteFile = 0xbbc;
var adErrNoCurrentRecord = 0xbcd;
var adErrIllegalOperation = 0xc93;
var adErrCantChangeProvider = 0xc94;
var adErrInTransaction = 0xcae;
var adErrFeatureNotAvailable = 0xcb3;
var adErrItemNotFound = 0xcc1;
var adErrObjectInCollection = 0xd27;
var adErrObjectNotSet = 0xd5c;
var adErrDataConversion = 0xd5d;
var adErrObjectClosed = 0xe78;
var adErrObjectOpen = 0xe79;
var adErrProviderNotFound = 0xe7a;
var adErrBoundToCommand = 0xe7b;
var adErrInvalidParamInfo = 0xe7c;
var adErrInvalidConnection = 0xe7d;
var adErrNotReentrant = 0xe7e;
var adErrStillExecuting = 0xe7f;
var adErrOperationCancelled = 0xe80;
var adErrStillConnecting = 0xe81;
var adErrInvalidTransaction = 0xe82;
var adErrUnsafeOperation = 0xe84;
var adwrnSecurityDialog = 0xe85;
var adwrnSecurityDialogHeader = 0xe86;
var adErrIntegrityViolation = 0xe87;
var adErrPermissionDenied = 0xe88;
var adErrDataOverflow = 0xe89;
var adErrSchemaViolation = 0xe8a;
var adErrSignMismatch = 0xe8b;
var adErrCantConvertvalue = 0xe8c;
var adErrCantCreate = 0xe8d;
var adErrColumnNotOnThisRow = 0xe8e;
var adErrURLIntegrViolSetColumns = 0xe8f;
var adErrURLDoesNotExist = 0xe8f;
var adErrTreePermissionDenied = 0xe90;
var adErrInvalidURL = 0xe91;
var adErrResourceLocked = 0xe92;
var adErrResourceExists = 0xe93;
var adErrCannotComplete = 0xe94;
var adErrVolumeNotFound = 0xe95;
var adErrOutOfSpace = 0xe96;
var adErrResourceOutOfScope = 0xe97;
var adErrUnavailable = 0xe98;
var adErrURLNamedRowDoesNotExist = 0xe99;
var adErrDelResOutOfScope = 0xe9a;
var adErrPropInvalidColumn = 0xe9b;
var adErrPropInvalidOption = 0xe9c;
var adErrPropInvalidValue = 0xe9d;
var adErrPropConflicting = 0xe9e;
var adErrPropNotAllSettable = 0xe9f;
var adErrPropNotSet = 0xea0;
var adErrPropNotSettable = 0xea1;
var adErrPropNotSupported = 0xea2;
var adErrCatalogNotSet = 0xea3;
var adErrCantChangeConnection = 0xea4;
var adErrFieldsUpdateFailed = 0xea5;
var adErrDenyNotSupported = 0xea6;
var adErrDenyTypeNotSupported = 0xea7;
var adErrProviderNotSpecified = 0xea9;
var adErrConnectionStringTooLong = 0xeaa;

//---- ParameterAttributesEnum Values ----
var adParamSigned = 0x0010;
var adParamNullable = 0x0040;
var adParamLong = 0x0080;

//---- ParameterDirectionEnum Values ----
var adParamUnknown = 0x0000;
var adParamInput = 0x0001;
var adParamOutput = 0x0002;
var adParamInputOutput = 0x0003;
var adParamReturnValue = 0x0004;

//---- CommandTypeEnum Values ----
var adCmdUnknown = 0x0008;
var adCmdText = 0x0001;
var adCmdTable = 0x0002;
var adCmdStoredProc = 0x0004;
var adCmdFile = 0x0100;
var adCmdTableDirect = 0x0200;

//---- EventStatusEnum Values ----
var adStatusOK = 0x0000001;
var adStatusErrorsOccurred = 0x0000002;
var adStatusCantDeny = 0x0000003;
var adStatusCancel = 0x0000004;
var adStatusUnwantedEvent = 0x0000005;

//---- EventReasonEnum Values ----
var adRsnAddNew = 1;
var adRsnDelete = 2;
var adRsnUpdate = 3;
var adRsnUndoUpdate = 4;
var adRsnUndoAddNew = 5;
var adRsnUndoDelete = 6;
var adRsnRequery = 7;
var adRsnResynch = 8;
var adRsnClose = 9;
var adRsnMove = 10;
var adRsnFirstChange = 11;
var adRsnMoveFirst = 12;
var adRsnMoveNext = 13;
var adRsnMovePrevious = 14;
var adRsnMoveLast = 15;

//---- SchemaEnum Values ----
var adSchemaProviderSpecific = -1;
var adSchemaAsserts = 0;
var adSchemaCatalogs = 1;
var adSchemaCharacterSets = 2;
var adSchemaCollations = 3;
var adSchemaColumns = 4;
var adSchemaCheckConstraints = 5;
var adSchemaConstraintColumnUsage = 6;
var adSchemaConstraintTableUsage = 7;
var adSchemaKeyColumnUsage = 8;
var adSchemaReferentialConstraints = 9;
var adSchemaTableConstraints = 10;
var adSchemaColumnsDomainUsage = 11;
var adSchemaIndexes = 12;
var adSchemaColumnPrivileges = 13;
var adSchemaTablePrivileges = 14;
var adSchemaUsagePrivileges = 15;
var adSchemaProcedures = 16;
var adSchemaSchemata = 17;
var adSchemaSQLLanguages = 18;
var adSchemaStatistics = 19;
var adSchemaTables = 20;
var adSchemaTranslations = 21;
var adSchemaProviderTypes = 22;
var adSchemaViews = 23;
var adSchemaViewColumnUsage = 24;
var adSchemaViewTableUsage = 25;
var adSchemaProcedureParameters = 26;
var adSchemaForeignKeys = 27;
var adSchemaPrimaryKeys = 28;
var adSchemaProcedureColumns = 29;
var adSchemaDBInfoKeywords = 30;
var adSchemaDBInfoLiterals = 31;
var adSchemaCubes = 32;
var adSchemaDimensions = 33;
var adSchemaHierarchies = 34;
var adSchemaLevels = 35;
var adSchemaMeasures = 36;
var adSchemaProperties = 37;
var adSchemaMembers = 38;
var adSchemaTrustees = 39;
var adSchemaFunctions = 40;
var adSchemaActions = 41;
var adSchemaCommands = 42;
var adSchemaSets = 43;

//---- FieldStatusEnum Values ----
var adFieldOK = 0;
var adFieldCantConvertValue = 2;
var adFieldIsNull = 3;
var adFieldTruncated = 4;
var adFieldSignMismatch = 5;
var adFieldDataOverflow = 6;
var adFieldCantCreate = 7;
var adFieldUnavailable = 8;
var adFieldPermissionDenied = 9;
var adFieldIntegrityViolation = 10;
var adFieldSchemaViolation = 11;
var adFieldBadStatus = 12;
var adFieldDefault = 13;
var adFieldIgnore = 15;
var adFieldDoesNotExist = 16;
var adFieldInvalidURL = 17;
var adFieldResourceLocked = 18;
var adFieldResourceExists = 19;
var adFieldCannotComplete = 20;
var adFieldVolumeNotFound = 21;
var adFieldOutOfSpace = 22;
var adFieldCannotDeleteSource = 23;
var adFieldReadOnly = 24;
var adFieldResourceOutOfScope = 25;
var adFieldAlreadyExists = 26;
var adFieldPendingInsert = 0x10000;
var adFieldPendingDelete = 0x20000;
var adFieldPendingChange = 0x40000;
var adFieldPendingUnknown = 0x80000;
var adFieldPendingUnknownDelete = 0x100000;

//---- SeekEnum Values ----
var adSeekFirstEQ = 0x1;
var adSeekLastEQ = 0x2;
var adSeekAfterEQ = 0x4;
var adSeekAfter = 0x8;
var adSeekBeforeEQ = 0x10;
var adSeekBefore = 0x20;

//---- ADCPROP_UPDATECRITERIA_ENUM Values ----
var adCriteriaKey = 0;
var adCriteriaAllCols = 1;
var adCriteriaUpdCols = 2;
var adCriteriaTimeStamp = 3;

//---- ADCPROP_ASYNCTHREADPRIORITY_ENUM Values ----
var adPriorityLowest = 1;
var adPriorityBelowNormal = 2;
var adPriorityNormal = 3;
var adPriorityAboveNormal = 4;
var adPriorityHighest = 5;

//---- ADCPROP_AUTORECALC_ENUM Values ----
var adRecalcUpFront = 0;
var adRecalcAlways = 1;

//---- ADCPROP_UPDATERESYNC_ENUM Values ----
var adResyncNone = 0;
var adResyncAutoIncrement = 1;
var adResyncConflicts = 2;
var adResyncUpdates = 4;
var adResyncInserts = 8;
var adResyncAll = 15;

//---- MoveRecordOptionsEnum Values ----
var adMoveUnspecified = -1;
var adMoveOverWrite = 1;
var adMoveDontUpdateLinks = 2;
var adMoveAllowEmulation = 4;

//---- CopyRecordOptionsEnum Values ----
var adCopyUnspecified = -1;
var adCopyOverWrite = 1;
var adCopyAllowEmulation = 4;
var adCopyNonRecursive = 2;

//---- StreamTypeEnum Values ----
var adTypeBinary = 1;
var adTypeText = 2;

//---- LineSeparatorEnum Values ----
var adLF = 10;
var adCR = 13;
var adCRLF = -1;

//---- StreamOpenOptionsEnum Values ----
var adOpenStreamUnspecified = -1;
var adOpenStreamAsync = 1;
var adOpenStreamFromRecord = 4;

//---- StreamWriteEnum Values ----
var adWriteChar = 0;
var adWriteLine = 1;

//---- SaveOptionsEnum Values ----
var adSaveCreateNotExist = 1;
var adSaveCreateOverWrite = 2;

//---- FieldEnum Values ----
var adDefaultStream = -1;
var adRecordURL = -2;

//---- StreamReadEnum Values ----
var adReadAll = -1;
var adReadLine = -2;

//---- RecordTypeEnum Values ----
var adSimpleRecord = 0;
var adCollectionRecord = 1;
var adStructDoc = 2;
%>