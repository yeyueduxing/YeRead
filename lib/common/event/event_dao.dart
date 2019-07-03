import 'package:event_bus/event_bus.dart';
import 'package:tianyue/common/event/collect_event.dart';

class EventDao{
  static sendCollectChange(){
    EventBus eventBus = new EventBus();
    eventBus.fire(new CollectEvent());
  }
}