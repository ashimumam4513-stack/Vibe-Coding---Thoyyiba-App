import os
import re

files = [
    "lib/features/home/home_screen.dart",
    "lib/features/store/shop_screen.dart",
    "lib/features/membership/membership_screen.dart",
    "lib/features/auth/sign_up_screen.dart",
    "lib/features/auth/login_screen.dart",
    "lib/features/explore/search_screen.dart",
    "lib/features/search/search_screen.dart"
]

for file in files:
    if not os.path.exists(file):
        continue
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1. Fix xxxxxxxxxl128px to xxxxxxxxxxl128px
    content = content.replace("xxxxxxxxxl128px", "xxxxxxxxxxl128px")

    # 2. Fix the brackets before bottomNavigationBar:
    # We want to find the last const AppFooter(), or const SizedBox(height: 64),
    # and replace all the garbage brackets after it until ottomNavigationBar:
    
    # Let's just use a regex to match all closing brackets and commas between the last valid widget and bottomNavigationBar
    # A safe way is to match (\s*const AppFooter\(\),)\s*[\], \n\t]+\s*bottomNavigationBar:
    # and replace with properly formatted brackets.
    
    content = re.sub(
        r'(\s*const AppFooter\(\),)[\s\],]+bottomNavigationBar:',
        r'\1\n              ],\n            ),\n          ),\n        ),\n      ],\n    ),\n    bottomNavigationBar:',
        content
    )
    
    with open(file, 'w', encoding='utf-8') as f:
        f.write(content)
        
    print(f"Fixed {file}")

