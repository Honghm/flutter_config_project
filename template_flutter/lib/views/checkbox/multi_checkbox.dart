import 'package:flutter/material.dart';
import 'package:template_flutter/views/checkbox/custom_checkbox.dart';

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
  /// * [icon], icon của checkbox
  /// * [shape], hình dạng của checkbox, mặc định là [BoxShape.rectangle].
  /// * [titleMaxLines], số dòng tối đa của title, mặc định là 2.
  /// * [margin], margin của checkbox, mặc định là EdgeInsets.all(4).
  /// * [padding], padding của checkbox, mặc định là EdgeInsets.zero.
  /// * [size], size của checkbox, mặc định là 24.
  /// * [borderRadius], borderRadius của checkbox, mặc định là 4, property này được
  /// bỏ qua nếu [shape] là [BoxShape.circle].
  MultiCheckbox({
    Key? key,
    required this.items,
    required this.onCheckChanged,
    this.scrollDirection = Axis.vertical,
    required this.crossAxisCount,
    this.checkedFillColor = Colors.blue,
    this.unCheckedBorderColor = Colors.grey,
    this.haveCheckIcon = true,
    this.icon,
    this.shape = BoxShape.rectangle,
    this.titleMaxLines = 2,
    this.mainAxisExtent = 50,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 5,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.all(4),
    this.size = 24,
    this.borderRadius,
  }) : super(key: key);
  final List<String> items;
  final Color checkedFillColor;
  final Color unCheckedBorderColor;
  final Widget? icon;
  final bool haveCheckIcon;
  final BoxShape shape;
  final int titleMaxLines;
  final void Function(List<String> selectedItems) onCheckChanged;
  final int crossAxisCount;
  final double mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Axis scrollDirection;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double size;
  final BorderRadius? borderRadius;
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
          child: CustomCheckbox(
            margin: widget.margin,
            padding: widget.padding,
            unCheckedBorderColor: widget.unCheckedBorderColor,
            checkedFillColor: widget.checkedFillColor,
            size: widget.size,
            shape: widget.shape,
            isChecked: checkBox.value,
            icon: widget.haveCheckIcon ? widget.icon : SizedBox(),
            borderRadius: widget.borderRadius,
            onChanged: (value) => setState(
              () {
                checkBox.value = value;
                final selectedItems = items
                    .where((element) => element.value == true)
                    .map((e) => e.title)
                    .toList();
                widget.onCheckChanged(selectedItems);
              },
            ),
          ),
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
