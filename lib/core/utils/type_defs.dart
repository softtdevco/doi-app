import 'package:doi_mobile/core/utils/enums.dart';

typedef BaseResponse<T> = ({bool status, String message, T? data});
typedef MessageText = ({String message, MessageType messageType});
