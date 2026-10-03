import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../struct/appState.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Giao diện tối'),
          subtitle: const Text('Thiết lập được lưu trên thiết bị.'),
          value: state.isDarkMode,
          onChanged: state.setDarkMode,
          secondary: const Icon(Icons.dark_mode_outlined),
        ),
        const AboutListTile(
          icon: Icon(Icons.info_outline),
          applicationName: 'StudyDocs',
          applicationVersion: '1.0.0',
          applicationLegalese: 'Quản lý tài liệu học tập lưu trữ cục bộ.',
        ),
      ],
    );
  }
}
