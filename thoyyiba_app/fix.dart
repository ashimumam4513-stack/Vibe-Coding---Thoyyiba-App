import 'dart:io';

void main() {
  final files = [
    'lib/features/home/home_screen.dart',
    'lib/features/store/shop_screen.dart',
    'lib/features/membership/membership_screen.dart',
    'lib/features/auth/sign_up_screen.dart',
    'lib/features/auth/login_screen.dart',
    'lib/features/explore/search_screen.dart',
    'lib/features/search/search_screen.dart'
  ];

  for (var path in files) {
    final file = File(path);
    if (!file.existsSync()) continue;
    
    var content = file.readAsStringSync();
    
    content = content.replaceAll('xxxxxxxxxl128px', 'xxxxxxxxxxl128px');
    
    final regex = RegExp(r'(\s*const AppFooter\(\),)[\s\S]*?bottomNavigationBar:');
    if (regex.hasMatch(content)) {
      content = content.replaceFirst(regex, '''\
              ],
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar:''');
    }

    file.writeAsStringSync(content);
  }
}
