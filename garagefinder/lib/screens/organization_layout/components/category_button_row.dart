import 'package:flutter/material.dart';

class CategoryButtonRow extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryButtonRow({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryButton(context, 'Public', Icons.school),
        _buildCategoryButton(context, 'Private', Icons.home_work),
        _buildCategoryButton(context, 'Community', Icons.account_balance),
      ],
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String label, IconData icon) {
    final isSelected = selectedCategory == label;
    return ElevatedButton.icon(
      onPressed: () => onCategorySelected(isSelected ? '' : label),
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
