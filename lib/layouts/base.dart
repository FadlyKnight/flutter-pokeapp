import 'package:flutter/material.dart';
// import all pages
import '../pages/login.dart';
import '../pages/store.dart';
import '../pages/listSearch.dart';
import '../pages/cart.dart';
import '../pages/register.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _currentIndex = 0;

  // List of pages to display in the body of the Scaffold
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const ListSearchPage(),
      const CartPage(),
      LoginPage(onNavigateToRegister: () => _onTabTapped(4)),
      RegisterPage(onNavigateToLogin: () => _onTabTapped(3)),
    ];
  }

  // function to handle tab changes
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeShop'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              _onTabTapped(2); // Navigate to CartPage
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implementasi notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifikasi Pokemon Baru')),
              );
            },
          ),
        ],
      ),
      /**
       * IndexedStack digunakan untuk menampilkan halaman yang berbeda
       * make sure state still live (form, scroll, controller, dsb)
       * navigation page smooth and less rebuild
       */
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex > 3 ? 3 : _currentIndex, // Clamp to valid tab indices
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pencarian'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
