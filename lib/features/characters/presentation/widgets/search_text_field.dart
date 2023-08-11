import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  final bool? enabled;

  const SearchTextField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
     this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}
