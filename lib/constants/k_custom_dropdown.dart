import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
class SelectDropdownButton extends StatelessWidget {
  final String buttonHint;
  final List<String> itemsList;
  final String? selectedValue;
  final bool? isBorderNeeded;
  final Function(String) onSelect;
  const SelectDropdownButton({
    super.key,
    required this.buttonHint,
    required this.itemsList,
    required this.selectedValue,
    required this.onSelect,
    this.isBorderNeeded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        style: const TextStyle(color: Colors.black),
        //* Icon customization
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: accentColor,
        )),
        isExpanded: true,

        //* Hint text
        hint: KMyText(
          buttonHint,
          color: Colors.black87,
          size: isBorderNeeded == null ? 14 : 16,
        ),
        items: itemsList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(item),
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) => onSelect(value!),

        // Dropdown button style
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 0.1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            color: backgroundColor.withOpacity(0.5),
          ),
        ),

        // Dropdown menu style
        dropdownStyleData: DropdownStyleData(
          maxHeight: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Menu items style
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
