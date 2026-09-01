import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/repository/onboarding_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required this.totalPages,
    required this.repository,
  }) : super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingCompleted>(_onCompleted);
  }

  final int totalPages;
  final OnboardingRepository repository;

  void _onPageChanged(OnboardingPageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      currentPage: event.pageIndex,
      isLastPage: event.pageIndex == totalPages - 1,
    ));
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    await repository.complete();
  }
}
