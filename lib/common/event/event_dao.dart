import 'package:event_bus/event_bus.dart';
import 'package:tianyue/common/event/collect_event.dart';
import 'package:tianyue/common/event/event_bus.dart';

class EventDao{
  static sendCollectChange(){
    if(ApplicationEvent.event!=null){
      print("发送通知");
      ApplicationEvent.event.fire(new CollectEvent());
    }else{
      final eventBus = new EventBus();
      ApplicationEvent.event = eventBus;
      ApplicationEvent.event.fire(new CollectEvent());
      print("发送通知2");
    }
  }
}