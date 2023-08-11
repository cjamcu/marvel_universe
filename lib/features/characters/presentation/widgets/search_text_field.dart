import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  final String hintText;
  final bool? enabled;

  const SearchTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: TextEditingController(),
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }
}
