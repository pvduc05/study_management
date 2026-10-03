import 'package:flutter/material.dart';

import '../pages/addDocumentPage.dart';
import '../pages/documentsListPage.dart';
import '../pages/favoritesPage.dart';
import '../pages/homePage.dart';
import '../pages/searchDocumentsPage.dart';
import '../pages/settingsPage.dart';

class NavigationFramework extends StatefulWidget {
  const NavigationFramework({super.key});

  @override
  State<NavigationFramework> createState() => _NavigationFrameworkState();
}

class _NavigationFrameworkState extends State<NavigationFramework> {
  int _selectedIndex = 0;
  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
    NavigationDestination(
      icon: Icon(Icons.library_books_outlined),
      label: 'Tài liệu',
    ),
    NavigationDestination(icon: Icon(Icons.search), label: 'Tìm kiếm'),
    NavigationDestination(icon: Icon(Icons.star_border), label: 'Yêu thích'),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      label: 'Cài đặt',
    ),
  ];

  Future<void> _addDocument() async {
    final saved = await Navigator.of(context)
        .push<bool>(MaterialPageRoute(builder: (_) => const AddDocumentPage()));
    if (saved == true && mounted) {
      setState(() => _selectedIndex = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'StudyDocs',
      'Tài liệu',
      'Tìm kiếm',
      'Yêu thích',
      'Cài đặt',
    ];
    final pages = [
      HomePage(
        onOpenDocuments: () => setState(() => _selectedIndex = 1),
        onOpenSearch: () => setState(() => _selectedIndex = 2),
      ),
      const DocumentsListPage(),
      const SearchDocumentsPage(),
      const FavoritesPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: IndexedStack(index: _selectedIndex, children: pages),
      floatingActionButton: _selectedIndex == 4
          ? null
          : FloatingActionButton.extended(
              onPressed: _addDocument,
              icon: const Icon(Icons.add),
              label: const Text('Thêm tài liệu'),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: _destinations,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
      ),
    );
  }
}
