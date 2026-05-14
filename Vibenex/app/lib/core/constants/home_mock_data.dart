import '../../features/home/domain/models/home_models.dart';

class HomeMockData {
  HomeMockData._();

  static final Map<String, FriendStatus> friendStatuses = {
    'user_alice': FriendStatus.accepted,
    'user_bob': FriendStatus.pending,
    'user_charlie': FriendStatus.none,
  };

  static final List<StoryModel> stories = [
    StoryModel(
      id: 'story_self',
      userName: 'Bạn',
      userAvatar: 'https://i.pravatar.cc/150?u=self',
      isOwn: true,
      isViewed: false,
    ),
    StoryModel(
      id: 'story_1',
      userName: 'Alice Nguyen',
      userAvatar: 'https://i.pravatar.cc/150?u=alice',
      isViewed: false,
    ),
    StoryModel(
      id: 'story_2',
      userName: 'Bob Tran',
      userAvatar: 'https://i.pravatar.cc/150?u=bob',
      isViewed: false,
    ),
    StoryModel(
      id: 'story_3',
      userName: 'Hyejin',
      userAvatar: 'https://i.pravatar.cc/150?u=hyejin',
      isViewed: true,
    ),
    StoryModel(
      id: 'story_4',
      userName: 'Charlie',
      userAvatar: 'https://i.pravatar.cc/150?u=charlie',
      isViewed: true,
    ),
  ];

  static final List<PostModel> posts = [
    PostModel(
      id: 'post_1',
      author: PostAuthor(
        id: 'user_alice',
        name: 'Alice Nguyen',
        avatar: 'https://i.pravatar.cc/150?u=alice',
        isVerified: true,
        isFriend: true,
      ),
      content: 'Một ngày tuyệt vời tại quán cà phê yêu thích của mình ☕️✨ Thích nhất không gian yên tĩnh và ly latte đậm đà ở đây.',
      imageUrls: [
        'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=500&q=80',
        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500&q=80',
      ],
      likeCount: 124,
      commentCount: 18,
      shareCount: 5,
      isLiked: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    PostModel(
      id: 'post_2',
      author: PostAuthor(
        id: 'user_bob',
        name: 'Bob Tran',
        avatar: 'https://i.pravatar.cc/150?u=bob',
        isFriend: false,
      ),
      content: 'Cuối cùng cũng xong project! Code chạy ngon lành 🚀 Chuẩn bị deploy thôi anh em ơi.',
      imageUrls: [
        'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500&q=80',
      ],
      likeCount: 89,
      commentCount: 42,
      shareCount: 12,
      isLiked: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    PostModel(
      id: 'post_3',
      author: PostAuthor(
        id: 'user_hyejin',
        name: 'Hyejin',
        avatar: 'https://i.pravatar.cc/150?u=hyejin',
        isVerified: true,
        isFriend: true,
      ),
      content: 'Chỉ là một dòng status vu vơ về thời tiết hôm nay. Trời trong xanh, mây trắng, gió nhẹ... thích hợp để đi dạo.',
      likeCount: 230,
      commentCount: 15,
      shareCount: 2,
      isLiked: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    PostModel(
      id: 'post_4',
      author: PostAuthor(
        id: 'user_charlie',
        name: 'Charlie',
        avatar: 'https://i.pravatar.cc/150?u=charlie',
        isFriend: false,
      ),
      content: 'Chuyến đi leo núi cuối tuần qua thật tuyệt! Không khí trong lành và cảnh đẹp mê hồn.',
      imageUrls: [
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=500&q=80',
        'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=500&q=80',
        'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=500&q=80',
      ],
      likeCount: 56,
      commentCount: 4,
      shareCount: 1,
      isLiked: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PostModel(
      id: 'post_5',
      author: PostAuthor(
        id: 'user_diana',
        name: 'Diana',
        avatar: 'https://i.pravatar.cc/150?u=diana',
        isFriend: true,
      ),
      content: 'Cún cưng của tôi vừa học được trò mới! Đáng yêu quá đi mất 🐶',
      imageUrls: [
        'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=500&q=80',
      ],
      likeCount: 412,
      commentCount: 88,
      shareCount: 20,
      isLiked: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
