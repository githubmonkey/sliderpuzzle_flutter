// ignore_for_file: public_member_api_docs

import 'package:leaders_api/leaders_api.dart';

enum LeadersViewFilter { all }

// TODO(s): this is not flexible enough
extension LeadersViewFilterX on LeadersViewFilter {
  bool apply(Leader leader) {
    switch (this) {
      case LeadersViewFilter.all:
        return true;
    // case LeadersViewFilter.activeOnly:
    //   return !leader.isCompleted;
    // case LeadersViewFilter.completedOnly:
    //   return leader.isCompleted;
    }
  }

  Iterable<Leader> applyAll(Iterable<Leader> leaders) {
    return leaders.where(apply);
  }
}
