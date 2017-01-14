//
//  RecordableSnapshots.swift
//  SlidableImage
//
//  Created by Pawel Bednorz on 14.01.2017.
//  Copyright © 2017 Quver. All rights reserved.
//

import Nimble
import Nimble_Snapshots

protocol RecordableSnapshots {

  var recordMode: Bool { get }

}

extension RecordableSnapshots {

  func recordValidSnapshot(usesDrawRect: Bool = false) -> MatcherFunc<Snapshotable> {
    return recordMode ? recordSnapshot() : haveValidSnapshot(usesDrawRect: usesDrawRect)
  }


}
