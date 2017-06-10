//
//  ConversationViewdModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol ConversationViewModelProtocol {
  ///
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var id: Int
  
  init(withConversationId id: Int) {
    self.id = id
  }
  
}
