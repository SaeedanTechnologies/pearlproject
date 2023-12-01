import 'package:flutter/material.dart';
import 'package:drag_and_drop_flutter/drag_and_drop_flutter.dart';



class MyHomePages extends StatefulWidget {


  @override
  State<MyHomePages> createState() => _MyHomePagesState();
}

enum DragState {
  inactive,
  over,
  dropped,
}

class _MyHomePagesState extends State<MyHomePages> {
  DragState _state = DragState.inactive;

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (_state == DragState.inactive) {
      text = 'Drag a file or folder on the app.';
    } else if (_state == DragState.over) {
      text = 'File or folder over app.';
    } else {
      text = 'You dropped something \u{1F451}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: DragDropArea(
        // Refuse images
        canDrop: (items) =>
            items.where((item) => item.type.contains('image/')).isEmpty,
        // Set a link when dragging out.
        dragData: DragData(
          type: DragDropType.copy,
          items: const [
            DataTransferItem.data(
              type: 'text/uri-list',
              data: 'https://jjagg.dev',
            ),
            DataTransferItem.data(
              type: 'text/plain',
              data: 'https://jjagg.dev',
            ),
          ],
        ),
        onDragEnter: (items) {
          debugPrint('Enter:');
          debugPrint(
            items.map((e) => '  ${e.isFile ? 'FILE' : e.type}').join('\n'),
          );

          setState(() {
            _state = DragState.over;
          });
        },
        onDragExit: () {
          debugPrint('Exit:');
          setState(() {
            _state = DragState.inactive;
          });
        },
        onDrop: (data) async {
          debugPrint('Drop:');
          debugPrint(
            data.items
                .map((e) => e.isFile
                    ? '  FILE: ${e.file!.name} (${e.file!.path})'
                    : '  DATA: ${e.data} (${e.type})')
                .join('\n'),
          );

          setState(() {
            _state = DragState.dropped;
          });
          await Future.delayed(const Duration(seconds: 2));
          if (_state == DragState.dropped) {
            setState(() {
              _state = DragState.inactive;
            });
          }
        },
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}