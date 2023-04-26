import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/widgets/entry_list_tile.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              EmployeeRequestListTile(
                title: "Vaction Request from Lena",
                subtitle: "May 12 - May 14",
                action: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.check),
                      color: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
        
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
