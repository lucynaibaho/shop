import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.cart,
    required this.onRemoveItem,
    required this.onClearCart,
  });

  final List<CartItemModel> cart;
  final void Function(String productId) onRemoveItem;
  final VoidCallback onClearCart;

  int get _grandTotal => cart.fold(0, (total, item) => total + item.subtotal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: cart.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    itemCount: cart.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 11),
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return _CartRow(
                        item: item,
                        onRemove: () => onRemoveItem(item.product.id),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Color(0xFFE8EBE5))),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Grand total',
                              style: TextStyle(
                                color: Color(0xFF68746E),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              formatRupiah(_grandTotal),
                              style: const TextStyle(
                                color: Color(0xFF142D2A),
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute<bool>(
                                  builder: (_) => CheckoutPage(
                                    cart: List<CartItemModel>.of(cart),
                                  ),
                                ),
                              );
                              if (result == true && context.mounted) {
                                onClearCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Pesanan berhasil dibuat.'),
                                    backgroundColor: Color(0xFF19745E),
                                  ),
                                );
                              }
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              backgroundColor: const Color(0xFF19745E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.item, required this.onRemove});

  final CartItemModel item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              item.product.imageUrl,
              width: 78,
              height: 78,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 78,
                height: 78,
                color: const Color(0xFFE5EDE7),
                child: const Icon(Icons.inventory_2_outlined),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF142D2A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.quantity} x ${formatRupiah(item.product.price)}',
                  style: const TextStyle(
                    color: Color(0xFF738179),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatRupiah(item.subtotal),
                  style: const TextStyle(
                    color: Color(0xFF19745E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Hapus ${item.product.name}',
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Color(0xFFB33A32),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(19),
              decoration: const BoxDecoration(
                color: Color(0xFFE4EEE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xFF19745E),
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                color: Color(0xFF142D2A),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Produk pilihanmu akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF738179)),
            ),
          ],
        ),
      ),
    );
  }
}
