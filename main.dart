import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'core/api_client.dart';
import 'core/token_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenStore.init();
  runApp(const WanasaApp());
}

class WanasaApp extends StatelessWidget {
  const WanasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomePage(),
      ProductsPage(),
      CartPage(),
      OrdersPage(),
      ProfilePage(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('وناسة الديرة'),
          centerTitle: true,
        ),
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.store_outlined), selectedIcon: Icon(Icons.store), label: 'المتجر'),
            NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'السلة'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'طلباتي'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('أهلاً بك 👋',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text('تصفية سريعة للأغذية الجافة والتجميل والعناية'),
        SizedBox(height: 16),
        CityCard(),
        SizedBox(height: 16),
        SectionTitle('أقسام الديرة'),
        CategoryTile('حارة الحلى والتسالي', Icons.cookie_outlined),
        CategoryTile('حارة التجميل والعناية', Icons.spa_outlined),
        CategoryTile('لقطة الديرة', Icons.local_offer_outlined),
        SizedBox(height: 12),
        SectionTitle('العروض السريعة'),
        ProductTile('منتج غذائي', 'متبقي 45 يوم', 'تصفية الديرة'),
        ProductTile('لقطة غذائية', 'متبقي 10 أيام', 'لقطة الديرة'),
        ProductTile('منتج عناية', 'متبقي 4 أشهر', 'عروض العناية'),
      ],
    );
  }
}

class CityCard extends StatelessWidget {
  const CityCard({super.key});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const Icon(Icons.location_city),
          title: const Text('المدينة'),
          subtitle: const Text('اختر مدينتك ومنطقتك'),
          trailing: const Icon(Icons.chevron_left),
          onTap: () => showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: const Text('اختر المدينة'),
              children: ['صنعاء', 'عدن', 'تعز', 'الحديدة']
                  .map((c) => SimpleDialogOption(
                        onPressed: () => Navigator.pop(context),
                        child: Text(c),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      );
}

class CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const CategoryTile(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.chevron_left),
        ),
      );
}

class ProductTile extends StatelessWidget {
  final String name;
  final String expiry;
  final String label;
  const ProductTile(this.name, this.expiry, this.label, {super.key});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const Icon(Icons.inventory_2_outlined),
          title: Text(name),
          subtitle: Text('$label • $expiry'),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {},
          ),
        ),
      );
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('المنتجات',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ProductTile('منتج غذائي للتصفية', 'متبقي 45 يوم', 'تصفية الديرة'),
          ProductTile('منتج غذائي لقطة', 'متبقي 10 أيام', 'لقطة الديرة'),
          ProductTile('منتج تجميل', 'متبقي 4 أشهر', 'عروض العناية'),
        ],
      );
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('السلة جاهزة للربط مع API'));
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('لا توجد طلبات حالياً'));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiClient(AppConfig.apiBaseUrl);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 42,
          child: Icon(Icons.person, size: 44),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text('حساب العميل',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.cloud_done),
            title: const Text('اختبار الاتصال بالـ API'),
            onTap: () async {
              final result = await api.get('/health');
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result ?? 'تعذر الاتصال')),
              );
            },
          ),
        ),
      ],
    );
  }
}
