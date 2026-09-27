import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.cart});

  final List<CartItemModel> cart;

  int get _total => cart.fold(0, (total, item) => total + item.subtotal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Konfirmasi pesanan',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text(
            'Ringkasan belanja',
            style: TextStyle(
              color: Color(0xFF142D2A),
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 13),
          ...cart.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.quantity} item',
                          style: const TextStyle(
                            color: Color(0xFF738179),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatRupiah(item.subtotal),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total pembayaran',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                formatRupiah(_total),
                style: const TextStyle(
                  color: Color(0xFF19745E),
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: const Color(0xFF19745E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Konfirmasi Pesanan'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batalkan'),
            ),
          ],
        ),
      ),
    );
  }
}
