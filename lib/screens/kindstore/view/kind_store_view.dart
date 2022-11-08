import 'package:flutter/material.dart';

class KindStoreCatalog extends StatefulWidget {
  const KindStoreCatalog({super.key});

  @override
  State<KindStoreCatalog> createState() => _KindStoreCatalogState();
}

class _KindStoreCatalogState extends State<KindStoreCatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data')),
    );
  }
}
