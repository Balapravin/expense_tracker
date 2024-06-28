import 'package:tracker/routes/index.dart';
import 'package:tracker/utils/tracker_path_export.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TrackerColour.kBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child:
                  BlocListener<FcmAuthenticationBloc, FcmAuthenticationState>(
                listener: (context, state) {
                  if (state is FcmAuthenticationLoadingState) {
                  } else if (state is FcmLoginSuccessState) {
                    Logger.successPrint(titleMessage: state.user);
                    Navigator.pushNamedAndRemoveUntil(context, PageRoutes.expenseList,(Route<dynamic> route) => true);

                  } else if (state is FcmAuthenticationFailedState) {
                    AppSnackBar.showSnackBar(context, state.errorMessage);
                  } else if (state is FcmAuthenticationExceptionState) {
                    AppSnackBar.showSnackBar(
                        context, state.exceptionErrorMessage);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign In",
                                style: TrackerTextStyles.kHeadlineLarge,
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              MyTextField(
                                controller: emailController,
                                hintText: 'Email',
                                inputType: TextInputType.text,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) =>
                                    TrackerValidator.validateEmail(
                                        email: email!),
                              ),
                              MyPasswordField(
                                hintText: "Password",
                                controller: passwordController,
                                isPasswordVisible: isPasswordVisible,
                                validator: (password) =>
                                    TrackerValidator.validatePassword(
                                        password: password),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Dont't have an account? ",
                            style: TrackerTextStyles.kLabelSmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, PageRoutes.register,);
                            },
                            child: Text(
                              'Register',
                              style: TrackerTextStyles.kLabelSmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      TrackerConstWidget.kSizeBox20,
                      MyTextButton(
                        buttonName: 'Sign In',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<FcmAuthenticationBloc>(context).add(
                                FcmAuthenticationLoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                            // FCMAuth.login(
                            //         email: emailController.text,
                            //         password: passwordController.text)
                            //     .then((value) =>
                            //         Logger.successPrint(message1: value));
                          }
                        },
                        bgColor: Colors.white,
                        textColor: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
