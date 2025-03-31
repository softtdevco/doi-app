import 'package:doi_mobile/gen/assets.gen.dart';

class Friend {
  final String? url;
  final String? name;
  final String status;

  Friend({
    this.url,
    this.name,
    required this.status,
  });
}

final waitingFriends = [
  Friend(
    status: 'Joined',
    name: 'Finneas',
    url: Assets.images.avatar2.path,
  ),
  Friend(
    status: 'Waiting',
    name: 'Finneas',
    url: Assets.images.avatar2.path,
  ),
  Friend(
    status: 'Waiting',
  ),
  Friend(
    status: 'Waiting',
  ),
];
