import 'package:tracker/routes/index.dart';
import 'package:tracker/utils/tracker_path_export.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child:
                  BlocListener<FcmAuthenticationBloc, FcmAuthenticationState>(
                listener: (context, state) {
                  if (state is FcmAuthenticationLoadingState) {
                  } else if (state is FcmRegistrationSuccessState) {
                    Logger.successPrint(
                        titleMessage: "FcmRegistrationSuccessState ---",
                        printObject: state.user);
                    BlocProvider.of<FcmAuthenticationBloc>(context)
                        .add(FcmSetUserDataEvent(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      userDetails: state.user,
                    ));
                  } else if (state is FcmSetUserDataSuccessState) {
                    Logger.successPrint(titleMessage: state.successMessage);
                    Navigator.pushNamedAndRemoveUntil(context, PageRoutes.expenseList,(Route<dynamic> route) => true);
                  } else if (state is FcmAuthenticationFailedState) {
                    AppSnackBar.showSnackBar(context, state.errorMessage);
                  } else if (state is FcmAuthenticationExceptionState) {
                    AppSnackBar.showSnackBar(
                        context, state.exceptionErrorMessage);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Register",
                                style: TrackerTextStyles.kHeadlineLarge,
                              ),
                              const Text(
                                "Create new account to get started.",
                                style: TrackerTextStyles.kHeadlineSmall,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              MyTextField(
                                controller: nameController,
                                hintText: 'Name',
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.name,
                                validator: (name) =>
                                    TrackerValidator.validateName(name: name!),
                              ),
                              MyTextField(
                                controller: emailController,
                                hintText: 'Email',
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.emailAddress,
                                validator: (email) =>
                                    TrackerValidator.validateEmail(
                                        email: email!),
                              ),
                              MyPasswordField(
                                hintText: 'Password',
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: passwordController,
                                isPasswordVisible: passwordVisibility,
                                validator: (password) =>
                                    TrackerValidator.validatePassword(
                                        password: password),
                                onTap: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
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
                            "Already have an account? ",
                            style: TrackerTextStyles.kLabelSmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TrackerTextStyles.kLabelSmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TrackerConstWidget.kSizeBox20,
                      MyTextButton(
                        buttonName: 'Register',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<FcmAuthenticationBloc>(context)
                                .add(FcmAuthenticationRegistrationEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                          }
                        },
                        bgColor: Colors.white,
                        textColor: Colors.black87,
                      )
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
