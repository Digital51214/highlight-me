// ═══════════════════════════════════════════════════════════════
//  PostAnalyticsModel  —  /api/post-analytics response model
//  Postman response se 1:1 match
// ═══════════════════════════════════════════════════════════════

class PostAnalyticsModel {
  final bool success;
  final String message;
  final AnalyticsData? data;

  PostAnalyticsModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory PostAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return PostAnalyticsModel(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      data: json['data'] != null
          ? AnalyticsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ───────────────────────────────────────────────────────────────
//  AnalyticsData  —  data: { type, summary, posts }
// ───────────────────────────────────────────────────────────────
class AnalyticsData {
  final String type;
  final AnalyticsSummary summary;
  final List<AnalyticsPost> posts;

  AnalyticsData({
    required this.type,
    required this.summary,
    required this.posts,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    final rawPosts = json['posts'];
    final List<AnalyticsPost> postList = rawPosts is List
        ? rawPosts
        .whereType<Map>()
        .map((e) => AnalyticsPost.fromJson(Map<String, dynamic>.from(e)))
        .toList()
        : [];

    return AnalyticsData(
      type: json['type']?.toString() ?? 'latest',
      summary: json['summary'] != null
          ? AnalyticsSummary.fromJson(
          json['summary'] as Map<String, dynamic>)
          : AnalyticsSummary.empty(),
      posts: postList,
    );
  }
}

// ───────────────────────────────────────────────────────────────
//  AnalyticsSummary  —  summary: { total_posts, total_views … }
// ───────────────────────────────────────────────────────────────
class AnalyticsSummary {
  final int totalPosts;
  final int totalViews;
  final int totalLikes;
  final int totalComments;
  final int totalShares;

  AnalyticsSummary({
    required this.totalPosts,
    required this.totalViews,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShares,
  });

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) {
    return AnalyticsSummary(
      totalPosts:    _parseInt(json['total_posts']),
      totalViews:    _parseInt(json['total_views']),
      totalLikes:    _parseInt(json['total_likes']),
      totalComments: _parseInt(json['total_comments']),
      totalShares:   _parseInt(json['total_shares']),
    );
  }

  factory AnalyticsSummary.empty() => AnalyticsSummary(
    totalPosts: 0,
    totalViews: 0,
    totalLikes: 0,
    totalComments: 0,
    totalShares: 0,
  );

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }
}

// ───────────────────────────────────────────────────────────────
//  AnalyticsPost  —  single post inside posts[]
// ───────────────────────────────────────────────────────────────
class AnalyticsPost {
  final int id;
  final int userId;
  final String type;        // "photo" | "video"
  final String? filePath;
  final String? thumbnail;
  final String? caption;
  final String? tags;
  final int viewsCount;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isActive;
  final bool isArchived;
  final String? createdAt;
  final String? updatedAt;

  // ✅ Direct full URLs — same as Postman response
  final String? fileUrl;
  final String? thumbnailUrl;
  final String? displayUrl;

  AnalyticsPost({
    required this.id,
    required this.userId,
    required this.type,
    this.filePath,
    this.thumbnail,
    this.caption,
    this.tags,
    required this.viewsCount,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.isActive,
    required this.isArchived,
    this.createdAt,
    this.updatedAt,
    this.fileUrl,
    this.thumbnailUrl,
    this.displayUrl,
  });

  factory AnalyticsPost.fromJson(Map<String, dynamic> json) {
    return AnalyticsPost(
      id:            _parseInt(json['id']),
      userId:        _parseInt(json['user_id']),
      type:          json['type']?.toString() ?? 'photo',
      filePath:      json['file_path']?.toString(),
      thumbnail:     json['thumbnail']?.toString(),
      caption:       json['caption']?.toString(),
      tags:          json['tags']?.toString(),
      viewsCount:    _parseInt(json['views_count']),
      likesCount:    _parseInt(json['likes_count']),
      commentsCount: _parseInt(json['comments_count']),
      sharesCount:   _parseInt(json['shares_count']),
      isActive:      json['is_active'] == 1 || json['is_active'] == true,
      isArchived:    json['is_archived'] == 1 || json['is_archived'] == true,
      createdAt:     json['created_at']?.toString(),
      updatedAt:     json['updated_at']?.toString(),
      fileUrl:       json['file_url']?.toString(),
      thumbnailUrl:  json['thumbnail_url']?.toString(),
      displayUrl:    json['display_url']?.toString(),
    );
  }

  /// Image dikhane ke liye best URL — displayUrl > fileUrl > thumbnailUrl
  String? get bestImageUrl => displayUrl ?? fileUrl ?? thumbnailUrl;

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }
}