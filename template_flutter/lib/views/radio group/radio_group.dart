import 'package:flutter/material.dart';
import 'package:template_flutter/views/checkbox/custom_checkbox.dart';
import 'package:template_flutter/views/radio%20group/custom_radio.dart';

class RadioGroup extends StatefulWidget {
  ///Widget chứa 1 hoặc nhiều checkbox, các checkbox được wrap trong [GridView]
  ///
  /// * [items], List<String> chứa title cho mỗi item.
  /// * [onCheckChanged], callback được gọi khi một checkbox thay đổi trạng thái,
  /// với tham số là String chứa title item được check.
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
  RadioGroup({
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
  final void Function(String selectedItems) onCheckChanged;
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
  _RadioGroupState createState() => _RadioGroupState();
}

class RadioState {
  final String title;
  bool value;
  RadioState({required this.title, this.value = false});
}

class _RadioGroupState extends State<RadioGroup> {
  List<RadioState> items = [];

  String? groupValue;
  @override
  void initState() {
    super.initState();
    items = widget.items.map((e) => RadioState(title: e)).toList();
    groupValue = widget.items.first;
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

  Widget _buildCheckBox(RadioState radio) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: widget.unCheckedBorderColor,
          ),
          child: CustomRadio<String>(
            margin: widget.margin,
            padding: widget.padding,
            unCheckedBorderColor: widget.unCheckedBorderColor,
            checkedFillColor: widget.checkedFillColor,
            size: widget.size,
            shape: widget.shape,
            value: radio.title,
            groupValue: groupValue!,
            icon: widget.haveCheckIcon ? widget.icon : SizedBox(),
            borderRadius: widget.borderRadius,
            onChanged: (String value) => setState(
              () {
                groupValue = value;
                widget.onCheckChanged(value);
              },
            ),
          ),
        ),
        Expanded(
          child: Text(
            radio.title,
            maxLines: widget.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
