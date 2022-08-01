import 'package:fluro/fluro.dart';
import '../util/routes.dart';
import '../view/home_screen.dart';
import '../view/location_denied_screen.dart';
import '../view/login_screen.dart';
import '../view/not_found.dart';
import '../view/signup_screen.dart';
import '../view/success_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();
  static Handler _homeHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  static Handler _deniedHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LocationDeniedScreen());
  static Handler _loginHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _signUpHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => SignUpScreen());
  static Handler _successHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => SuccessScreen());
  static Handler _notFoundHandler = Handler(handlerFunc: (context, Map<String, dynamic> params) => NotFound());

  static void setupRouter() {
    router.notFoundHandler = _notFoundHandler;
    router.define(Routes.HOME_SCREEN, handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DENIED_SCREEN, handler: _deniedHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN, handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.SIGN_UP_SCREEN, handler: _signUpHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.SUCCESS_SCREEN, handler: _successHandler, transitionType: TransitionType.fadeIn);
  }
}