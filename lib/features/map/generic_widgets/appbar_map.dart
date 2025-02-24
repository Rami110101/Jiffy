import 'package:competition/core/utils/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/cubit/route/route_cubit.dart';
import '../screens/history_screen.dart';
import '../screens/search_screen.dart';

class AppBarMap extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMap({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppStrings.map.tr(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            HistoryScreen.routeName,
            arguments: context.read<RouteCubit>().historyMarkers,
          );
        },
        icon: const Icon(
          Icons.history,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchScreen.routeName);
          },
          icon: const Icon(
            CupertinoIcons.search,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
