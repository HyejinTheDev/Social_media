import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/models/space_models.dart';

class SpaceCard extends StatelessWidget {
  final SpaceModel space;

  const SpaceCard({super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () {
              // TODO: Navigate to space detail
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (space.coverPhoto != null)
                  Image.network(
                    space.coverPhoto!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [cs.primary.withValues(alpha: 0.5), cs.secondary.withValues(alpha: 0.5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(child: Icon(Icons.rocket_launch, size: 48, color: Colors.white54)),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (space.avatar != null)
                            CircleAvatar(
                              backgroundImage: NetworkImage(space.avatar!),
                              radius: 20,
                            )
                          else
                            CircleAvatar(
                              backgroundColor: cs.primary,
                              radius: 20,
                              child: const Icon(Icons.group, color: Colors.white, size: 20),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  space.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.people_outline, size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${space.membersCount} members',
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                    if (space.isPrivate) ...[
                                      const SizedBox(width: 8),
                                      Icon(Icons.lock_outline, size: 14, color: cs.secondary),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (space.description != null && space.description!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          space.description!,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
