import 'package:clinic_consultation_app/core/extensions/build_context_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: context.deviceHeight,
                width: context.deviceWidth,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Column(
                  children: [
                    const SpaceHeight(24),
                    Image.asset(
                      Assets.images.logo.path,
                      height: 75,
                      width: 66,
                    ),
                    const SizedBox(height: 24),
                    Image.asset(
                      Assets.images.onboardingDoctor.path,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  width: context.deviceWidth,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        16,
                      ),
                      topLeft: Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SpaceHeight(16),
                      const Text(
                        "Jaga Kesehatan, Dimana Saja",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SpaceHeight(6),
                      const Text(
                        "Konsultasikan kesehatan Anda kapan saja dan di mana saja bersama profesional terpercaya",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                      const SpaceHeight(
                        36,
                      ),
                      Button.filled(
                        height: 48,
                        onPressed: () async {
                          await signInWithGoogle();
                        },
                        label: 'Masuk dengan Google',
                        icon: Image.asset(
                          Assets.images.google.path,
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                        fontSize: 14.0,
                      ),
                      const SpaceHeight(26),
                      Button.filled(onPressed: () {}, label: 'Doctor Page'),
                      const SpaceHeight(26),
                      Button.filled(onPressed: () {}, label: 'Admin Page'),
                      const SpaceHeight(26),
                      const Text(
                        "Powerred by",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                      const SpaceHeight(6),
                      Image.asset(
                        Assets.images.jf4.path,
                        // height: 60,
                        width: 80,
                        color: AppColors.primary,
                      ),
                      const SpaceHeight(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
