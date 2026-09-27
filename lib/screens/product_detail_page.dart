import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  final ProductModel product;
  final void Function(ProductModel product, int quantity) onAddToCart;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void _addToCart() {
    widget.onAddToCart(widget.product, _quantity);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$_quantity item berhasil ditambahkan ke keranjang.'),
          backgroundColor: const Color(0xFF19745E),
        ),
      );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail produk')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 28),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.12,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: const Color(0xFFE5EDE7),
                  alignment: Alignment.center,
                  child: const Icon(Icons.inventory_2_outlined, size: 64),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            product.category.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF738179),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF142D2A),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatRupiah(product.price),
            style: const TextStyle(
              color: Color(0xFF19745E),
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            product.description,
            style: const TextStyle(
              color: Color(0xFF5F6B64),
              height: 1.6,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kuantitas',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: const Color(0xFFE2E6E0)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Kurangi kuantitas',
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    SizedBox(
                      width: 30,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Tambah kuantitas',
                      onPressed: () => setState(() => _quantity++),
                      icon: const Icon(Icons.add_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 14),
        child: FilledButton.icon(
          onPressed: _addToCart,
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text('Tambah ke Keranjang'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            backgroundColor: const Color(0xFF19745E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
