import 'package:flutter/widgets.dart';
import 'package:flutter_shoper/presentation/features/shop/product/product_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../data/auth/authenticator.dart';
import '../presentation/features/home/home_screen.dart';
import '../presentation/features/login/login_screen.dart';
import '../presentation/features/orders/orders_screen.dart';
import '../presentation/root_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final navigationProvider = Provider((ref) {
  final user = ref.watch(authenticatorProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = user != null;
      final bool loggingIn = state.subloc == '/login';
      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return '/';
      }

      // no need to redirect at all
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const RootScreen();
          },
          routes: [
            GoRoute(
              name: 'product',
              path: 'product/:id/:name',
              builder: (BuildContext context, GoRouterState state) {
                return ShopItemScreen(productId: state.params['id']!, name: state.params['name']!,);
              },
            ),
            GoRoute(
              path: 'home',
              builder: (BuildContext context, GoRouterState state) {
                return HomeScreen();
              },
            ),
            GoRoute(
              path: 'order',
              builder: (BuildContext context, GoRouterState state) {
                return OrdersScreen();
              },
            ),
          ]),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      )
    ],
  );
});
