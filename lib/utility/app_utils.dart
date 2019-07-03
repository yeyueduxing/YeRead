
class AppUtils{
  static String joinCover(String comId) {
    return "http://image.samanlehua.com/mh/"+comId+".jpg-960x1280.jpg.webp";
  }

  static String showLookNum(int num) {
    if(num==null){
      return "暂无观看";
    }
    return "观看次数 "+num.toString();
    if(num<10000){
      return "观看次数 "+num.toString();
    }else if(num<10000*100){
      double look = (num/10000) ;
      return "观看次数 "+look.toString()+"万";
    }else if(num<10000*10000){
      double look = (num/1000000) ;
      return "观看次数 "+look.toString()+"百万";
    }else{
      double look = (num/1000000000);
      return "观看次数 "+look.toString()+"亿";
    }

  }
  static String showNovelCover(String cover) {
    return "http://statics.zhuishushenqi.com"+cover;
  }

  static String showNovelTime(String time) {
    time = time.replaceFirst("T", " ");
    time = time.replaceFirst("Z", " ");
    return time;
  }
}