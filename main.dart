import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const TechStoreApp());
}

class TechStoreApp extends StatelessWidget {
  const TechStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechStore Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CatalogHomePage(),
    );
  }
}

// Veri Modeli Sınıfı
class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final IconData icon;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.icon,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class CatalogHomePage extends StatefulWidget {
  const CatalogHomePage({super.key});

  @override
  State<CatalogHomePage> createState() => _CatalogHomePageState();
}

class _CatalogHomePageState extends State<CatalogHomePage> {
  int cartCount = 0;
  String searchQuery = "";

  // JSON Simülasyon Veri Listesi[cite: 6]
  final List<Product> products = [
    Product.fromJson({
      'id': 1,
      'name': 'AirPods Pro 2',
      'category': 'Ses & Kulaklık',
      'price': 8499,
      'description': 'Aktif gürültü engelleme ve şeffaf mod özellikli kablosuz kulaklık.',
      'icon': Icons.headphones,
    }),
    Product.fromJson({
      'id': 2,
      'name': 'MacBook Air M3',
      'category': 'Bilgisayar',
      'price': 44999,
      'description': '13.6 inç Liquid Retina ekran, 16 GB RAM ve 18 saate varan pil ömrü.',
      'icon': Icons.laptop_mac,
    }),
    Product.fromJson({
      'id': 3,
      'name': 'iPad Air 11"',
      'category': 'Tablet',
      'price': 25999,
      'description': 'M2 çip gücünde ince ve hafif tasarım, Apple Pencil uyumlu.',
      'icon': Icons.tablet_mac,
    }),
    Product.fromJson({
      'id': 4,
      'name': 'Watch Series 9',
      'category': 'Giyilebilir',
      'price': 14999,
      'description': 'Gelişmiş sağlık sensörleri ve parlak Always-On Retina ekran.',
      'icon': Icons.watch,
    }),
    Product.fromJson({
      'id': 5,
      'name': 'Mekanik Klavye',
      'category': 'Aksesuar',
      'price': 3299,
      'description': 'RGB aydınlatmalı, Türkçe Q dizilimli kablosuz mekanik klavye.',
      'icon': Icons.keyboard,
    }),
    Product.fromJson({
      'id': 6,
      'name': 'Kablosuz Mouse',
      'category': 'Aksesuar',
      'price': 1899,
      'description': 'Ergonomik tasarım, yüksek hassasiyetli optik sensör.',
      'icon': Icons.mouse,
    }),
  ];

  void addToCart() {
    setState(() {
      cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TechStore Katalog', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Badge(
              label: Text('$cartCount'),
              child: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Banner Kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Keşfet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  SizedBox(height: 4),
                  Text('İhtiyacın olan teknoloji ürününü hemen incele.', style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Arama Çubuğu[cite: 6]
            TextField(
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 12),
            // GridView Ürün Listesi[cite: 6]
            Expanded(
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.82,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            onAddToCart: addToCart,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.indigo.shade100,
                              child: Icon(product.icon, size: 32, color: Colors.indigo),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Text(product.category, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            const Spacer(),
                            Text(
                              '${product.price.toStringAsFixed(0)} ₺',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Ürün Detay Ekranı[cite: 6]
class ProductDetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(product.icon, size: 80, color: Colors.indigo),
              ),
            ),
            const SizedBox(height: 24),
            Text(product.category, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(product.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              '${product.price.toStringAsFixed(0)} ₺',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Text('Ürün Açıklaması', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(product.description, style: const TextStyle(fontSize: 15, height: 1.4)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  onAddToCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} sepete eklendi!')),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Sepete Ekle', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}