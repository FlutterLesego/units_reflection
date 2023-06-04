import 'package:backendless_todo_starter/misc/constants.dart';
import 'package:backendless_todo_starter/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UnitCard extends StatelessWidget {
  const UnitCard(
      {Key? key,
      required this.unit,
      required this.deleteAction,
      required this.todoToggleAction,
      required this.onTap})
      : super(key: key);
  final Unit unit;
  final Function(BuildContext context) deleteAction;
  final Function(bool? value) todoToggleAction;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              label: 'Delete',
              backgroundColor: Colors.deepOrange,
              icon: Icons.delete,
              onPressed: deleteAction,
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap,
          subtitle: Text(
              '${unit.created.day}/${unit.created.month}/${unit.created.year}',
              style: appTextStyle(12, Colors.grey, FontWeight.w400)),
          title: Text(
            unit.unitDesc,
            style: TextStyle(
              color: Colors.black,
              decoration:
                  unit.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
