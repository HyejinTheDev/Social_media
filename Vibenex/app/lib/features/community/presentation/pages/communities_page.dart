import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/community_bloc.dart';
import '../widgets/community_card.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CommunityBloc>().add(const LoadCommunitiesRequested());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<CommunityBloc>().state;
      if (state is CommunityLoaded && !state.hasReachedMax) {
        context.read<CommunityBloc>().add(LoadCommunitiesRequested(page: state.currentPage + 1));
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
            title: const Text('Communities', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: cs.primary),
                onPressed: () {
                  context.push('/create-community');
                },
              ),
            ],
          ),
          BlocBuilder<CommunityBloc, CommunityState>(
            builder: (context, state) {
              if (state is CommunityInitial || (state is CommunityLoading && state is! CommunityLoaded)) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: cs.primary)),
                );
              }
              if (state is CommunityError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(state.message, style: const TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () => context.read<CommunityBloc>().add(const LoadCommunitiesRequested()),
                          child: Text('Thử lại', style: TextStyle(color: cs.primary)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is CommunityLoaded) {
                if (state.communities.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Chưa có cộng đồng nào. Hãy tạo mới!', style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.communities.length) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(color: cs.primary),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CommunityCard(community: state.communities[index]),
                        );
                      },
                      childCount: state.hasReachedMax ? state.communities.length : state.communities.length + 1,
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
