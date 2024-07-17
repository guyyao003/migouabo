import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../backend/backend.dart';
import '../../auth/base_auth_user_provider.dart';
import '../../main.dart';
import '../../flutter_flow/flutter_flow_util.dart';
export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

import '../../pages/onboarding/splash/splash_widget.dart';
import '../../pages/onboarding/sign_in/sign_in_widget.dart';
import '../../pages/onboarding/onboarding_slideshow/onboarding_slideshow_widget.dart';
import '../../pages/onboarding/onboarding_create_account/onboarding_create_account_widget.dart';
import '../../pages/onboarding/forgot_password/forgot_password_widget.dart';
import '../../pages/profile/profile/profile_widget.dart';
import '../../pages/profile/edit_preferences/edit_preferences_widget.dart';
import '../../pages/meals/acceuil/acceuil_widget.dart';
import '../../pages/meals/categorie/categorie_widget.dart';
import '../../commande_valide/commande_valide_widget.dart';
import '../../panier/panier_widget.dart';
import '../../detail_produit/detail_produit_widget.dart';
import '../../liste_product_base/liste_product_base_widget.dart';
import '../../pages/edit_profile/edit_profile_widget.dart';
import '../../pages/profile/about_us/about_us_widget.dart';
import '../../pages/profile/support_center/support_center_widget.dart';
import '../../moyendepaiement/moyendepaiement_widget.dart';
import '../../modif_detail_produit/modif_detail_produit_widget.dart';
import '../../methode_payment/methode_payment_widget.dart';









const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const NavBarPage() : const SplashWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const NavBarPage() : const SplashWidget(),
          routes: [
            FFRoute(
              name: 'Splash',
              path: 'splash',
              builder: (context, params) => const SplashWidget(),
            ),
            FFRoute(
              name: 'SignIn',
              path: 'sign-in',
              builder: (context, params) => const SignInWidget(),
            ),
            FFRoute(
              name: 'Onboarding_Slideshow',
              path: 'onboarding',
              builder: (context, params) => const OnboardingSlideshowWidget(),
            ),
            FFRoute(
              name: 'Onboarding_CreateAccount',
              path: 'create-account',
              builder: (context, params) => const OnboardingCreateAccountWidget(),
            ),
            FFRoute(
              name: 'Profile',
              path: 'profile',
              requireAuth: true,
              builder: (context, params) => params.isEmpty
                  ? const NavBarPage(initialPage: 'Profile')
                  : const ProfileWidget(),
            ),
            FFRoute(
              name: 'EditProfile',
              path: 'edit-profile',
              requireAuth: true,
              builder: (context, params) => const EditProfileWidget(),
            ),
            FFRoute(
              name: 'AboutUs',
              path: 'about-us',
              requireAuth: true,
              builder: (context, params) => const AboutUsWidget(),
            ),
            FFRoute(
              name: 'SupportCenter',
              path: 'support-center',
              requireAuth: true,
              builder: (context, params) => const SupportCenterWidget(),
            ),
            FFRoute(
              name: 'ForgotPassword',
              path: 'forgot-password',
              builder: (context, params) => const ForgotPasswordWidget(),
            ),
            FFRoute(
              name: 'EditPreferences',
              path: 'edit-preferences',
              requireAuth: true,
              builder: (context, params) => EditPreferencesWidget(
                page: params.getParam(
                  'page',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: 'Acceuil',
              path: 'acceuil',
              builder: (context, params) => params.isEmpty
                  ? const NavBarPage(initialPage: 'Acceuil')
                  : const AcceuilWidget(),
            ),
            FFRoute(
              name: 'Categorie',
              path: 'categorie',
              builder: (context, params) => params.isEmpty
                  ? const NavBarPage(initialPage: 'Categorie')
                  : const CategorieWidget(),
            ),
            // FFRoute(
            //   name: 'ListeProductFruits',
            //   path: 'listeProductFruits',
            //   builder: (context, params) => const ListeProductFruitsWidget(),
            // ),
            // FFRoute(
            //   name: 'ListeProductLegume',
            //   path: 'listeProductLegume',
            //   builder: (context, params) => const NavBarPage(
            //     initialPage: '',
            //     page: ListeProductLegumeWidget(),
            //   ),
            // ),
            // FFRoute(
            //   name: 'ListeProductViande',
            //   path: 'listeProductViande',
            //   builder: (context, params) => const NavBarPage(
            //     initialPage: '',
            //     page: ListeProductViandeWidget(),
            //   ),
            // ),
            // FFRoute(
            //   name: 'ListeProductPoisson',
            //   path: 'listeProductPoisson',
            //   builder: (context, params) => const NavBarPage(
            //     initialPage: '',
            //     page: ListeProductPoissonWidget(),
            //   ),
            // ),
            FFRoute(
              name: 'ListeProductBase',
              path: 'listeProductBase',
              builder: (context, params) => const NavBarPage(
                initialPage: '',
                page: ListeProductBaseWidget(),
              ),
            ),
            // FFRoute(
            //   name: 'ListeProductBoisson',
            //   path: 'listeProductBoisson',
            //   builder: (context, params) => const NavBarPage(
            //     initialPage: '',
            //     page: ListeProductBoissonWidget(),
            //   ),
            // ),
            FFRoute(
              name: 'DetailProduit',
              path: 'detailProduit',
              asyncParams: {
                'fruits': getDoc(['produits'], ProduitsRecord.fromSnapshot),
                'panier': getDoc(['Panier'], PanierRecord.fromSnapshot),
              },
              builder: (context, params) => DetailProduitWidget(
                fruits: params.getParam(
                  'fruits',
                  ParamType.Document,
                ),
                panier: params.getParam(
                  'panier',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'Panier',
              path: 'panier',
              builder: (context, params) => const PanierWidget(),
            ),
            FFRoute(
              name: 'ModifDetailProduit',
              path: 'modifDetailProduit',
              asyncParams: {
                'panier': getDoc(['Panier'], PanierRecord.fromSnapshot),
              },
              builder: (context, params) => ModifDetailProduitWidget(
                panier: params.getParam(
                  'panier',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: 'Commande_Valide',
              path: 'commandeValide',
              builder: (context, params) => const CommandeValideWidget(),
            ),
            FFRoute(
              name: 'moyendepaiement',
              path: 'moyendepaiement',
              builder: (context, params) => const MoyendepaiementWidget(),
            ),
            FFRoute(
              name: 'methode_payment',
              path: 'methodePayment',
              builder: (context, params) => const MethodePaymentWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/splash';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Colorful_Illustrative_Organic_Grocery_Online_Shop_Logo-removebg-preview.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
