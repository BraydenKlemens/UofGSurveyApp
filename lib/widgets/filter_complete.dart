import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class FilterComplete extends StatelessWidget {
  const FilterComplete({ Key? key, required this.showCompleted }) : super(key: key);
  final bool showCompleted;

  @override
  Widget build(BuildContext context) {
    //Filter widget tree
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: OutlinedButton(
          onPressed: () => Provider.of<AppProvider>(context, listen: false).showFilter(),
          child: Row(
            children:[
              Icon((showCompleted) ? Icons.expand_more : Icons.chevron_right),
              const Text('Completed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(width: 10),
            ],
          ),
        )
      ),
    );
  }
}