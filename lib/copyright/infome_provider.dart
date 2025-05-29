import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalkulator/copyright/infome_state.dart';

final infomeProvider = NotifierProvider(() => InfomeNotifer());

class InfomeNotifer extends Notifier<InfomeState> {
  @override
  InfomeState build() {
    return InfomeState();
  }
}
