
import 'package:doi_mobile/core/utils/type_defs.dart';

extension ObjectExtensions<T> on T {
  BaseResponse<T> toBaseResponse({
    bool status = true,
    String message = '',
  }) {
    return (
      status: status,
      message: message,
      data: this,
    );
  }
}
