import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/themes/app_colors.dart';

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.category,
    required this.time,
    required this.isdone,
  });
  late int id;
  String title;
  String category;
  String time;
  int isdone;

  List<Map> prority = [
    {"name": "Low", "color": Color(0xff3DBE8B)},
    {"name": "Medium", "color": Color(0xffF5A524)},
    {"name": "High", "color": Color(0xffE5484D)},
  ];
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool v = (widget.isdone == 0) ? false : true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        v = !v;
        setState(() {});
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

              style: Theme.of(context).primaryTextTheme.titleMedium,
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
                color: widget.prority[widget.id]["color"].withAlpha(39),
              ),
              child: Text(
                widget.prority[widget.id]["name"],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: widget.prority[widget.id]["color"],
                ),
              ),
            ),
            leading: Transform.scale(
              scale: 1.6,
              child: Checkbox(
                value: v,
                onChanged: (value) {
                  HapticFeedback.selectionClick();
                  v = value!;
                  setState(() {});
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
