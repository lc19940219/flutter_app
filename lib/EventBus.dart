import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class ProductContentEvent {
  String name;
  ProductContentEvent(this.name);
}
class UserEvent {
  String name;
  UserEvent(this.name);
}