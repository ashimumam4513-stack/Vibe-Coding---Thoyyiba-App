import re

file_path = r'C:\Belajar_vibe_coding_Thoyyiba\thoyyiba_app\lib\features\home\home_screen.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

old_content = '''                child: ClipPath(
                  clipper: TornPaperClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark ? Colors.white10 : Colors.black12,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined, size: 64, color: mutedColor.withOpacity(0.5)),
                          const SizedBox(height: AppSpacing.xl16px),
                          Text('Hero Image (Torn Edges)', style: TextStyle(color: mutedColor.withOpacity(0.5))),
                        ],
                      ),
                    ),
                  ),
                ),'''

new_content = '''                child: ClipPath(
                  clipper: TornPaperClipper(),
                  child: Image.asset(
                    'assets/images/hero_honey.png',
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),'''

# Normalize newlines
old_content = old_content.replace('\r\n', '\n')
content_norm = content.replace('\r\n', '\n')

if old_content in content_norm:
    content_norm = content_norm.replace(old_content, new_content)
    with open(file_path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(content_norm)
    print('Replaced successfully')
else:
    print('Could not find exact text. Here is what is there:')
    import textwrap
    start = content_norm.find('clipper: TornPaperClipper()')
    print(content_norm[start-50:start+400])

