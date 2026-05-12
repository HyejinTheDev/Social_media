import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/space_bloc.dart';
import '../widgets/space_card.dart';

class SpacesPage extends StatefulWidget {
  const SpacesPage({super.key});

  @override
  State<SpacesPage> createState() => _SpacesPageState();
}

class _SpacesPageState extends State<SpacesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SpaceBloc>().add(const LoadSpacesRequested());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<SpaceBloc>().state;
      if (state is SpaceLoaded && !state.hasReachedMax) {
        context.read<SpaceBloc>().add(LoadSpacesRequested(page: state.currentPage + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: const FlexibleSpaceBar(),
              ),
            ),
            title: const Text('Cosmic Spaces', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: cs.primary),
                onPressed: () {
                  // TODO: Create space flow
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create Space (Coming Soon)')));
                },
              ),
            ],
          ),
          BlocBuilder<SpaceBloc, SpaceState>(
            builder: (context, state) {
              if (state is SpaceInitial || (state is SpaceLoading && state is! SpaceLoaded)) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: cs.primary)),
                );
              }
              if (state is SpaceError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(state.message, style: const TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () => context.read<SpaceBloc>().add(const LoadSpacesRequested()),
                          child: Text('Thử lại', style: TextStyle(color: cs.primary)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is SpaceLoaded) {
                if (state.spaces.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Chưa có không gian nào. Hãy tạo một Space mới!', style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.spaces.length) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(color: cs.primary),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: SpaceCard(space: state.spaces[index]),
                        );
                      },
                      childCount: state.hasReachedMax ? state.spaces.length : state.spaces.length + 1,
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
