import 'package:intl/intl.dart';

// TODO: parameter date 와 현재시간 비교하여 시간 찍기
class DateTimeUtils {
  static Future<String> timeAgo(DateTime date) async{
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return (DateFormat('yyyy년 MM월 dd일').format(date)).toString(); // 1주 이상은 날짜 형식으로 반환
    }
  }
}