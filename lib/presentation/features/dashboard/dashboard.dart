import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/friends.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/home.dart';
import 'package:doi_mobile/presentation/features/dashboard/tournaments/presentation/pages/tournaments.dart';
import 'package:doi_mobile/presentation/features/dashboard/wallet/presentation/pages/wallet.dart';
import 'package:doi_mobile/presentation/features/dashboard/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(currentIndexProvider),
        children: const [
          Home(),
          Friends(),
          Tournaments(),
          Wallet(),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
