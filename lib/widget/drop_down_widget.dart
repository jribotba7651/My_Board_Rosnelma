import '../imports.dart';

class DropDownListWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String hintText;
  final String? prefixIconPath;
  const DropDownListWidget({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    required this.hintText,
    this.prefixIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.067,
      child: DropdownButtonFormField<String>(
        menuMaxHeight: Get.height * 0.5,
        padding: EdgeInsets.zero,
        icon: SizedBox(
          width: 0,
        ),
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyles.smallText!.copyWith(color: Colors.black),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          prefixIcon: prefixIconPath != null
              ? SizedBox(
                  height: Get.height * 0.02,
                  width: Get.width * 0.03,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: SvgPicture.asset(
                      prefixIconPath!,
                      fit: BoxFit.contain,
                    ),
                  ))
              : null,
          suffixIcon: Icon(
            Icons.expand_more,
            color: Colors.grey,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
