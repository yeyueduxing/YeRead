import 'package:tianyue/utility/app_utils.dart';

class ComicData{
   String cover;
   String title;
   String description;

   ComicData.fromJson(Map data) {
     cover = AppUtils.joinCover(data['id']);
     title = data['name'];
     description = data['author'];
   }
}
