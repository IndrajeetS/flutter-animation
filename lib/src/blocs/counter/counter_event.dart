part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {}

class CounterIncrementEvent extends CounterEvent {
  @override
  List<Object?> get props => [];
}

class CounterDecrementEvent extends CounterEvent {
  @override
  List<Object?> get props => [];
}
