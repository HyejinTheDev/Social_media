class NotificationMockData {
  NotificationMockData._();

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 'notif_1',
      'type': 'friend_request',
      'title': 'Lời mời kết bạn',
      'body': 'Bob Tran đã gửi cho bạn một lời mời kết bạn.',
      'avatar': 'https://i.pravatar.cc/150?u=bob',
      'time': '10 phút trước',
      'isRead': false,
    },
    {
      'id': 'notif_2',
      'type': 'new_post',
      'title': 'Bài viết mới từ bạn bè',
      'body': 'Alice Nguyen vừa đăng một bài viết mới: "Một ngày tuyệt vời tại quán cà phê..."',
      'avatar': 'https://i.pravatar.cc/150?u=alice',
      'time': '45 phút trước',
      'isRead': false,
    },
    {
      'id': 'notif_3',
      'type': 'like',
      'title': 'Lượt thích mới',
      'body': 'Charlie và 12 người khác đã thích bài viết của bạn.',
      'avatar': 'https://i.pravatar.cc/150?u=charlie',
      'time': '2 giờ trước',
      'isRead': true,
    },
    {
      'id': 'notif_4',
      'type': 'comment',
      'title': 'Bình luận mới',
      'body': 'Diana đã bình luận về bài viết của bạn: "Wow, đẹp quá!"',
      'avatar': 'https://i.pravatar.cc/150?u=diana',
      'time': 'Hôm qua',
      'isRead': true,
    },
  ];

  static int get unreadCount => notifications.where((n) => !(n['isRead'] as bool)).length;
}
