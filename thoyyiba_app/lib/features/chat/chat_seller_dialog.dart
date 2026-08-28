import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_tokens.dart';

class ChatSellerDialog extends StatefulWidget {
  final bool isDark;

  const ChatSellerDialog({
    super.key,
    required this.isDark,
  });

  @override
  State<ChatSellerDialog> createState() => _ChatSellerDialogState();
}

class _ChatSellerDialogState extends State<ChatSellerDialog> {
  final TextEditingController _controller = TextEditingController();
  
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Halo! Ada yang bisa kami bantu?', 'isUser': false},
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({'text': text.trim(), 'isUser': true});
    });
    
    _controller.clear();
    
    // Simulate auto-reply
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({'text': 'Terima kasih atas pesan Anda. Kami akan segera membalasnya!', 'isUser': false});
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDark ? const Color(0xFF1E1A17) : const Color(0xFFF9F6F0);
    final textColor = widget.isDark ? Colors.white : Colors.black;
    final mutedColor = widget.isDark ? Colors.white70 : Colors.black54;
    final brandColor = const Color(0xFFCE9B2F);
    final dividerColor = widget.isDark ? Colors.white24 : Colors.black12;

    return Dialog(
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xs4px),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thoyyiba Care',
                        style: const TextStyle(fontFamily: 'Nura').copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ONLINE • BALAS CEPAT',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          color: brandColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: textColor, size: 20),
                  ),
                ],
              ),
            ),
            Divider(color: dividerColor, height: 1, thickness: 1),
            
            // Chat Content
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['isUser'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isUser 
                              ? brandColor 
                              : (widget.isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                          borderRadius: BorderRadius.circular(AppRadius.xs4px),
                        ),
                        child: Text(
                          msg['text'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isUser ? Colors.white : textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Quick Replies
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickReply('APAKAH STOK TERSEDIA?', textColor, dividerColor),
                  _buildQuickReply('BERAPA LAMA PENGIRIMAN?', textColor, dividerColor),
                  _buildQuickReply('BISA NEGO HARGA?', textColor, dividerColor),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: dividerColor, height: 1, thickness: 1),
            
            // Input Area
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.inter(color: textColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan...',
                        hintStyle: GoogleFonts.inter(color: mutedColor, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _sendMessage(_controller.text),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.isDark ? Colors.white : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(AppRadius.xs4px),
                      ),
                      child: Icon(
                        Icons.send_outlined,
                        size: 18,
                        color: widget.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReply(String text, Color textColor, Color dividerColor) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: dividerColor),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 10,
            letterSpacing: 0.5,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
