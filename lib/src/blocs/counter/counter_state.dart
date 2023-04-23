// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_bloc.dart';

class CounterState {
  int counter;
  CounterState({required this.counter});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(counter: 0);
}
