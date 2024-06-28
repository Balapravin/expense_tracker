import 'package:tracker/utils/tracker_path_export.dart';

part 'fcm_authentication_event.dart';
part 'fcm_authentication_state.dart';

class FcmAuthenticationBloc
    extends Bloc<FcmAuthenticationEvent, FcmAuthenticationState> {
  FcmAuthenticationBloc() : super(FcmAuthenticationInitialState()) {
    // Event handlers registration
    on<FcmAuthenticationRegistrationEvent>(_registrationEvent);
    on<FcmAuthenticationLoginEvent>(_loginEvent);
    on<FcmAuthenticationLogoutEvent>(_logoutEvent);
    on<FcmSetUserDataEvent>(_saveUserToDBEvent);
  }

  // Event handler for user registration
  Future<void> _registrationEvent(FcmAuthenticationRegistrationEvent event,
      Emitter<FcmAuthenticationState> emit) async {
    emit(FcmAuthenticationLoadingState()); // Emit loading state

    FirebaseAuth fcmAuth = FirebaseAuth.instance;
    try {
      // Create user with email and password
      UserCredential userCredential =
          await fcmAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Update user display name
      await userCredential.user!.updateDisplayName(event.name);
      await userCredential.user!.reload();

      // Fetch updated user
      User? user = fcmAuth.currentUser;

      // Emit success state with user information
      emit(FcmRegistrationSuccessState(user: user!));
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      emit(FcmAuthenticationFailedState(errorMessage: e.code));
    } catch (e) {
      // Handle other exceptions
      emit(
          FcmAuthenticationExceptionState(exceptionErrorMessage: e.toString()));
      throw Exception(e);
    }
  }

  // Event handler for user login
  Future<void> _loginEvent(FcmAuthenticationLoginEvent event,
      Emitter<FcmAuthenticationState> emit) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    emit(FcmAuthenticationLoadingState()); // Emit loading state
    try {
      // Sign in with email and password
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Emit success state with user information
      emit(FcmLoginSuccessState(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      emit(FcmAuthenticationFailedState(errorMessage: e.code));
    } catch (e) {
      // Handle other exceptions
      emit(
          FcmAuthenticationExceptionState(exceptionErrorMessage: e.toString()));
      throw Exception(e);
    }
  }

  // Event handler for user logout
  Future<void> _logoutEvent(FcmAuthenticationLogoutEvent event,
      Emitter<FcmAuthenticationState> emit) async {
    emit(FcmAuthenticationLoadingState()); // Emit loading state
    try {
      // Sign out the user
      await FirebaseAuth.instance.signOut();

      // Emit logout success state
      emit(FcmAuthenticationLogoutSuccessState(logoutMessage: "SUCCESS"));
    } catch (e) {
      // Handle exceptions
      emit(
          FcmAuthenticationExceptionState(exceptionErrorMessage: e.toString()));
    }
  }

  /// Saves user data to the FireStore database including user image if available.
  Future<void> _saveUserToDBEvent(
      FcmSetUserDataEvent event, Emitter<FcmAuthenticationState> emit) async {
    try {
      if (event.userDetails != null) {
        // Construct user data model
        UserRegistrationModel userSendData = UserRegistrationModel(
          userName: event.name,
          emailId: event.email,
          password: event.password,
        );

        // Save user data to Firestore
        final userDb = FirebaseFirestore.instance
            .collection("users")
            .doc(event.userDetails!.uid);

        await userDb.set(userSendData.toJson()).then((value) {
          emit(FcmSetUserDataSuccessState(successMessage: "SUCCESS"));
        });
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      emit(FcmAuthenticationFailedState(errorMessage: e.code));
    } catch (e) {
      // Handle other exceptions
      emit(
          FcmAuthenticationExceptionState(exceptionErrorMessage: e.toString()));
      throw Exception(e);
    }
  }
}
