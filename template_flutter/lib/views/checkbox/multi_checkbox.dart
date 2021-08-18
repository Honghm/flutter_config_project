import 'package:flutter/material.dart';

class MultiCheckbox extends StatefulWidget {
  ///Widget chứa 1 hoặc nhiều checkbox, các checkbox được wrap trong [GridView]
  ///
  /// * [items], List<String> chứa title cho mỗi item.
  /// * [onCheckChanged], callback được gọi khi một checkbox thay đổi trạng thái,
  /// với tham số là List<String> chứa title các item được check.
  /// * [scrollDirection], chiều scroll của [GridView], mặc định là [Axis.vertical].
  /// * [crossAxisCount], số cột của [GridView] nếu chiều scroll là [Axis.vertical]
  /// số dòng của [GridView] nếu chiều scroll là [Axis.horizontal]. Gán = 1 thì sẽ thành [ListView].
  /// * [checkedFillColor], fill color của checkbox khi nó được check, mặc định
  /// là [Colors.blue].
  /// * [unCheckedBorderColor], màu viền của checkbox khi nó không được check,
  /// mặc định là [Colors.grey].
  /// * [haveCheckIcon], true nếu muốn hiển thị check icon, mặc định là true.
  /// * [checkIconColor], màu của check icon, thuộc tính này được bỏ qua nếu
  /// [haveCheckIcon] = false, mặc định là [Colors.white].
  /// * [shape], hình dạng của checkbox, mặc định là [RoundedRectangleBorder]
  /// với cornerRadius là 1.0.
  /// * [titleMaxLines], số dòng tối đa của title, mặc định là 2.
  ///
  MultiCheckbox({
    Key? key,
    required this.items,
    required this.onCheckChanged,
    this.scrollDirection = Axis.vertical,
    required this.crossAxisCount,
    this.checkedFillColor = Colors.blue,
    this.unCheckedBorderColor = Colors.grey,
    this.haveCheckIcon = true,
    this.checkIconColor = Colors.white,
    this.shape,
    this.titleMaxLines = 2,
    this.mainAxisExtent = 50,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 5,
  }) : super(key: key);
  final List<String> items;
  final Color checkedFillColor;
  final Color unCheckedBorderColor;
  final Color checkIconColor;
  final bool haveCheckIcon;
  final OutlinedBorder? shape;
  final int titleMaxLines;
  final void Function(List<String> selectedItems) onCheckChanged;
  final int crossAxisCount;
  final double mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Axis scrollDirection;
  @override
  _MultiCheckboxState createState() => _MultiCheckboxState();
}

class CheckBoxState {
  final String title;
  bool value;
  CheckBoxState({required this.title, this.value = false});
}

class _MultiCheckboxState extends State<MultiCheckbox> {
  List<CheckBoxState> items = [];
  @override
  void initState() {
    super.initState();
    items = widget.items.map((e) => CheckBoxState(title: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      scrollDirection: widget.scrollDirection,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: widget.mainAxisSpacing,
        mainAxisExtent: widget.mainAxisExtent,
        crossAxisSpacing: widget.crossAxisSpacing,
      ),
      children: items.map(_buildCheckBox).toList(),
    );
  }

  Widget _buildCheckBox(CheckBoxState checkBox) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: widget.unCheckedBorderColor,
          ),
          child: Checkbox(
              shape: widget.shape,
              activeColor: widget.checkedFillColor,
              checkColor: widget.haveCheckIcon
                  ? widget.checkIconColor
                  : widget.checkedFillColor,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: checkBox.value,
              onChanged: (value) => setState(() {
                    checkBox.value = value!;
                    final selectedItems = items
                        .where((element) => element.value == true)
                        .map((e) => e.title)
                        .toList();
                    widget.onCheckChanged(selectedItems);
                  })),
        ),
        Expanded(
          child: Text(
            checkBox.title,
            maxLines: widget.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
