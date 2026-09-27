import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onAddToCart});

  final void Function(ProductModel product, int quantity) onAddToCart;

  static const products = <ProductModel>[
    ProductModel(
      id: 'mug-01',
      name: 'Tumbler Termal',
      category: 'Perlengkapan',
      price: 89000,
      description: 'Tumbler stainless steel berdinding ganda untuk menjaga minuman tetap hangat atau dingin saat beraktivitas di kampus.',
      imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=900&q=85',
    ),
    ProductModel(
      id: 'bag-02',
      name: 'Totebag Kanvas',
      category: 'Aksesori',
      price: 65000,
      description: 'Tas kanvas ringan dengan ruang luas untuk membawa buku, laptop kecil, dan kebutuhan kuliah sehari-hari.',
      imageUrl: 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=900&q=85',
    ),
    ProductModel(
      id: 'notebook-03',
      name: 'Notebook Linen',
      category: 'Alat tulis',
      price: 42000,
      description: 'Buku catatan dotted dengan sampul linen dan kertas tebal yang nyaman untuk catatan kelas maupun sketsa.',
      imageUrl: 'https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=900&q=85',
    ),
    ProductModel(
      id: 'lamp-04',
      name: 'Lampu Meja Mini',
      category: 'Ruang belajar',
      price: 119000,
      description: 'Lampu meja berdesain ringkas dengan cahaya lembut untuk menemani sesi belajar dan membaca.',
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=900&q=85',
    ),
    ProductModel(
      id: 'headphone-05',
      name: 'Headphone Studio',
      category: 'Elektronik',
      price: 249000,
      description: 'Headphone nyaman dengan bantalan empuk, cocok untuk fokus belajar, kelas daring, dan mendengarkan musik.',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=85',
    ),
    ProductModel(
      id: 'bottle-06',
      name: 'Botol Tritan',
      category: 'Perlengkapan',
      price: 57000,
      description: 'Botol minum transparan bebas BPA dengan tutup rapat dan kapasitas yang pas untuk dibawa ke kelas.',
      imageUrl: 'https://images.unsplash.com/photo-1608270586620-248524c67de9?auto=format&fit=crop&w=900&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ruang Belanja',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 23),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(21, 22, 15, 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF174F43),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PILIHAN MINGGU INI',
                            style: TextStyle(
                              color: Color(0xFFBCE0CB),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: 9),
                          Text(
                            'Teman baik\nuntuk hari kuliah.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.local_mall_rounded,
                      color: Color(0xFFF3BF7B),
                      size: 68,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Pilihan untukmu',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF142D2A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${products.length} produk',
                    style: const TextStyle(color: Color(0xFF748078)),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.crossAxisExtent > 650 ? 3 : 2;
                return SliverGrid.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                    childAspectRatio: 0.69,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _ProductCard(
                      product: product,
                      onTap: () => Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => ProductDetailPage(
                            product: product,
                            onAddToCart: onAddToCart,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox.expand(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: const Color(0xFFE5EDE7),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Color(0xFF578072),
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF738179),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF142D2A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(product.price),
                    style: const TextStyle(
                      color: Color(0xFF19745E),
                      fontWeight: FontWeight.w800,
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
}
