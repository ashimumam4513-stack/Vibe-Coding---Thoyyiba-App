import 'package:flutter/material.dart';
import '../../core/state/cart_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/app_footer.dart';
import '../../../shared/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const SearchScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy data for preview
  final List<Map<String, String>> _allProducts = [
    {'title': 'Wild Trigona', 'price': 'Rp 450.000', 'imageUrl': 'assets/images/wild_trigona.png'},
    {'title': 'Sumbawa Forest Gold', 'price': 'Rp 250.000', 'imageUrl': 'assets/images/sumbawa_forest_gold.png'},
    {'title': 'Herbal Infusion No. 4', 'price': 'Rp 210.000', 'imageUrl': 'assets/images/herbal_infusion.png'},
    {'title': 'Golden Etawa Milk', 'price': 'Rp 185.000', 'imageUrl': 'assets/images/golden_etawa_milk.png'},
    {'title': 'Raw Java Blossom Honey', 'price': 'Rp 310.000', 'imageUrl': 'assets/images/java_blossom.png'},
    {'title': 'Forest Propolis Drops', 'price': 'Rp 245.000', 'imageUrl': 'assets/images/forest_propolis_drops.png'},
  ];

  final List<String> _recommendations = [
    'Trigona',
    'Forest',
    'Herbal',
    'Milk',
    'Propolis',
  ];

  List<Map<String, String>> get _filteredProducts {
    if (_searchQuery.isEmpty) return _allProducts;
    return _allProducts.where((product) {
      return product['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onRecommendationTap(String rec) {
    _searchController.text = rec;
    // Move cursor to end
    _searchController.selection = TextSelection.fromPosition(TextPosition(offset: _searchController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final brandColor = const Color(0xFFCE9B2F);

    final currentProducts = _filteredProducts;

    return Scaffold(
      extendBody: true,
      body: Column(
          children: [
            CustomAppBar(
              onThemeToggle: widget.onThemeToggle,
              isDarkMode: widget.isDarkMode,
            ),
            Expanded(
              child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'SEARCH',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: brandColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'FIND YOUR JAR.',
                  style: const TextStyle(fontFamily: 'Nura').copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Search Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Honey, herbal, goat milk...',
                    hintStyle: GoogleFonts.inter(
                      color: mutedColor.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.search, color: mutedColor, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty 
                        ? IconButton(
                            icon: Icon(Icons.clear, color: mutedColor, size: 20),
                            onPressed: () => _searchController.clear(),
                          ) 
                        : null,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: dividerColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: brandColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Search Recommendations
              if (_searchQuery.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECOMMENDED SEARCHES',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: mutedColor.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _recommendations.map((rec) {
                          return ActionChip(
                            label: Text(rec),
                            labelStyle: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 12,
                            ),
                            backgroundColor: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                            ),
                            onPressed: () => _onRecommendationTap(rec),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              if (_searchQuery.isEmpty) const SizedBox(height: 24),

              // Items Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '${currentProducts.length} ITEMS',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: mutedColor.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Grid of Products
              if (currentProducts.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Center(
                    child: Text(
                      'No products found matching "$_searchQuery"',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: mutedColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: currentProducts.length,
                    itemBuilder: (context, index) {
                      final product = currentProducts[index];
                      return ProductCard(
                          showShareIcon: false,
                          imageUrl: product['imageUrl'] ?? '',
                        title: product['title']!,
                        price: product['price']!,
                        onAddToCart: () {
                            CartState.addItem(CartItem(
                              id: product['title']!,
                              title: product['title']!,
                              price: product['price']!,
                              imageUrl: product['imageUrl'] ?? '',
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product['title']} added to bag')),
                            );
                          },
                      );
                    },
                  ),
                ),

              const SizedBox(height: 64),
              const AppFooter(),
              const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
    
    );
  }
}











