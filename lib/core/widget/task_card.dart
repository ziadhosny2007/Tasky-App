import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/themes/app_colors.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.priorityId,
    required this.title,
    required this.category,
    required this.time,
    required this.isdone,
    required this.id,
  });
  late int priorityId;
  String title;
  String category;
  String time;
  int isdone;
  int id;

  List<Map> prority = [
    {"name": "Low", "color": Color(0xff3DBE8B)},
    {"name": "Medium", "color": Color(0xffF5A524)},
    {"name": "High", "color": Color(0xffE5484D)},
  ];
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Sqldb db = Sqldb();
  Future<int> exciuteTask(bool x) async {
    int isDone = (x) ? 1 : 0;
    final data = await db.updateData(
      "UPDATE tasks SET is_done =$isDone WHERE id = ${widget.id}",
    );
    return data;
  }

  late bool v = (widget.isdone == 0) ? false : true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.lightImpact();
        setState(() => v = !v);
        await exciuteTask(v);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Container(
          height: 70,
          width: 350,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: .center,
          child: ListTile(
            isThreeLine: true,
            title: Text(
              widget.title,
              maxLines: 1,
              style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(
                decoration: v
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: v ? const Color(0xff6E6B7B) : null,
                decorationThickness: 2,
                decorationColor: const Color(0xff6E6B7B),
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  "${widget.category} •  ${widget.time}",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: .bold,
                    color: Color(0xff6E6B7B),
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.prority[widget.priorityId]["color"].withAlpha(39),
              ),
              child: Text(
                widget.prority[widget.priorityId]["name"],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: widget.prority[widget.priorityId]["color"],
                ),
              ),
            ),
            leading: Transform.scale(
              scale: 1.6,
              child: Checkbox(
                value: v,
                onChanged: (value) async {
                  HapticFeedback.selectionClick();
                  setState(() => v = value!);
                  await exciuteTask(v);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                activeColor: AppColors.highlight,
                checkColor: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
