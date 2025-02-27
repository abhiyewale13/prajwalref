import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/core/custom_snackbar.dart';
import '../../email/email_verification.dart';
import '../../phone_number/phone_number.dart';
import '../auth_service/auth_service.dart';
import '../cubit/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showEmailField = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      if (keyboardHeight > 0 && _showEmailField) {
        _scrollToTextField();
      }
    });
  }

  void _scrollToTextField() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final scrollAmount =
            _scrollController.position.maxScrollExtent + keyboardHeight;
        _scrollController.animateTo(
          scrollAmount,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ScaffoldMessenger(
      child: Material(
        child: Stack(
          children: [
            Image.asset(
              "assets/splash/back.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/splash/gradient.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                bottomInset > 0
                                    ? bottomInset * 0.4
                                    : size.height * 0.1,
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Image.asset(
                                "assets/splash/logo.png",
                                width: size.width * 0.5,
                                height: size.height * 0.12,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Dubai's award-winning Desi club \nexperience awaits you!",
                                style: GoogleFonts.urbanist(
                                  color: Colors.white70,
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: size.height * 0.08),
                              _buildButtons(context, size),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showEmailField) _buildEmailInput(size),

          if (!_showEmailField)
            SignInButton(
              label: "Continue with Email",
              imageUrl: "assets/sign_up_assets/mail.svg",
              onTap: () {
                setState(() {
                  _showEmailField = true;
                });
                _scrollToTextField();
              },
            ),
          const SizedBox(height: 12),
          SignInButton(
            label: isLoading ? "Signing in..." : "Continue with Google",
            imageUrl: "assets/sign_up_assets/google.svg",
            onTap: () async {
              if (isLoading) return;
              setState(() {
                isLoading = true;
              });

              try {
                final user = await _authService.signInWithGoogle();

                if (user != null) {
                  context.read<AuthCubit>().setUserEmail(user.email ?? "");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneNumber()),
                  );
                } else {
                  showCustomSnackbar(
                    context,
                    "Sign-in failed. Please try again.",
                    Colors.red.shade600,
                  );
                }
              } catch (e) {
                showCustomSnackbar(
                  context,
                  "An error occurred. Please try again.",
                  Colors.red.shade600,
                );
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
            isLoading: isLoading,
          ),

          const SizedBox(height: 12),

          SignInButton(
            label: "Continue with Apple",
            imageUrl: "assets/sign_up_assets/apple.svg",
            onTap: () {
              showCustomSnackbar(context, "Coming soon", Colors.green.shade600);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please enter your email ",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Switzer',
              fontSize: size.width * 0.035,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onTap: _scrollToTextField,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xff3579DD)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3579DD)),
              ),
            ),
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              // if (isLoading) return;
              String email = _emailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                showCustomSnackbar(
                  context,
                  "Enter a valid email",
                  Colors.green.shade600,
                );
                return;
              }
              setState(() => isLoading = true);
              try {
                await Supabase.instance.client.auth.signInWithOtp(
                  // shouldCreateUser: false,
                  email: email,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailVerification(email: email),
                  ),
                );
              } catch (e) {
                showCustomSnackbar(
                  context,
                  "Failed to send OTP. Try again.",
                  Colors.red.shade600,
                );
              }
              setState(() => isLoading = false);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff3579DD),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Center(
                child:
                    isLoading
                        ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2.5,
                          ),
                        )
                        : Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Switzer',
                          ),
                          textAlign: TextAlign.center,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class SignInButton extends StatelessWidget {
  final String label;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isLoading;
  const SignInButton({
    super.key,
    required this.label,
    required this.imageUrl,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double iconSize = size.width * 0.05;
    double fontSize = size.width * 0.04;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: padding,
          horizontal: padding * 2,
        ),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.015),
        ),
        child:
            isLoading
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      imageUrl,
                      height: iconSize,
                      width: iconSize,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
