import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    required this.studentName,
    required this.studentNim,
  });

  final String studentName;
  final String studentNim;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<CartItemModel> _cart = [];
  int _selectedIndex = 0;

  void _addToCart(ProductModel product, int quantity) {
    if (quantity <= 0) return;
    setState(() {
      final existing = _cart.where((item) => item.product.id == product.id);
      if (existing.isNotEmpty) {
        existing.first.quantity += quantity;
      } else {
        _cart.add(CartItemModel(product: product, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String productId) {
    setState(() => _cart.removeWhere((item) => item.product.id == productId));
  }

  void _clearCart() {
    setState(_cart.clear);
  }

  int get _cartQuantity =>
      _cart.fold(0, (total, item) => total + item.quantity);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onAddToCart: _addToCart),
      CartPage(
        cart: _cart,
        onRemoveItem: _removeFromCart,
        onClearCart: _clearCart,
      ),
      ProfilePage(
        studentName: widget.studentName,
        studentNim: widget.studentNim,
        onLogout: () {
          _clearCart();
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (_) => const LoginPage()),
            (_) => false,
          );
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: _CartIcon(count: _cartQuantity),
            selectedIcon: _CartIcon(count: _cartQuantity, selected: true),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  const _CartIcon({required this.count, this.selected = false});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      child: Icon(
        selected ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
      ),
    );
  }
}
