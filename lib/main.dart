import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: const [
              Icon(Icons.person),
              Icon(Icons.message),
              Icon(Icons.call),
              Icon(Icons.camera),
              Icon(Icons.photo),
            ],
          ),
        ),
      ),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({super.key, required this.items});

  final List<Icon> items;

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  late List<Icon> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Draggable<Icon>(
          data: item,
          feedback: Transform.scale(
            scale: 1.2,
            child: _buildDockItem(item),
          ),
          childWhenDragging: const SizedBox.shrink(),
          onDragCompleted: () {},
          onDragEnd: (details) {
            // Handle position drop and reordering
          },
          child: DragTarget<Icon>(
            onWillAccept: (draggedItem) => true,
            onAccept: (draggedItem) {
              setState(() {
                final oldIndex = _items.indexOf(draggedItem);
                _items.removeAt(oldIndex);
                _items.insert(index, draggedItem);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return MouseRegion(
                onEnter: (_) => _onHover(item, true),
                onExit: (_) => _onHover(item, false),
                child: _buildDockItem(item),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDockItem(Icon icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      constraints: const BoxConstraints(minWidth: 48),
      height: 48,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
      ),
      child: Center(child: icon),
    );
  }

  void _onHover(Icon item, bool isHovered) {
    setState(() {

    });
  }
}
