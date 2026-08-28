import re
with open(r'C:\Belajar_vibe_coding_Thoyyiba\thoyyiba_app\lib\features\home\home_screen.dart', 'r') as f:
    text = f.read()

# Add import
if 'auth_state.dart' not in text:
    text = text.replace("import '../auth/sign_up_screen.dart';", "import '../auth/sign_up_screen.dart';\nimport '../../core/state/auth_state.dart';")

# Remove JournalSection call
text = re.sub(r'(_buildTheCircleSection\(theme, textColor, mutedColor\),)\s*_buildJournalSection\(theme, textColor, mutedColor\),', r'\1', text)

# Replace button
old_btn = '''            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Sign In or Sign Up',
'''
new_btn = '''            ValueListenableBuilder<bool>(
              valueListenable: AuthState.isLoggedIn,
              builder: (context, isLoggedIn, child) {
                if (isLoggedIn) return const SizedBox.shrink();
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Sign In or Sign Up',
'''
text = text.replace(old_btn, new_btn)

old_end = '''                  );
                },
              ),
            ),
          ],
        ),'''
new_end = '''                  );
                },
              ),
            );
            }),
          ],
        ),'''
text = text.replace(old_end, new_end)

with open(r'C:\Belajar_vibe_coding_Thoyyiba\thoyyiba_app\lib\features\home\home_screen.dart', 'w') as f:
    f.write(text)
