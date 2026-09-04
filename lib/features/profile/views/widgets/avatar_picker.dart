import 'package:flutter/material.dart';

const List<IconData> kAvatarIcons = [
  Icons.person_rounded,
  Icons.face_rounded,
  Icons.pets_rounded,
  Icons.sports_esports_rounded,
  Icons.music_note_rounded,
  Icons.brush_rounded,
];

class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: kAvatarIcons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primaryContainer,
              child: Icon(
                kAvatarIcons[index],
                color: isSelected ? Colors.white : theme.colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
