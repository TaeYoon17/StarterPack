//
//  AdapterPattern.swift
//  oop_design_pattern
//
//  Created by Greem on 4/5/25.
//

import Foundation
enum Behavior { }

enum AdapterPattern {
    /// 새로운 인터페이스를 정의하는 클래스
    class Target {
        func request() -> String {
            "Tareget: The default target's behavior"
        }
    }
    /// 기존의 인터페이스를 가진 클래스
    class Adaptee {
        func specific_request() -> String {
            "Adaptee: The specific request"
        }
    }
    
    /// Target 인터페이스를 구현하는 클래스
    /// Adaptee 클래스의 인스턴스를 내부에 포함시키면서 Target 인터페이스의 request 메서드를 구현
    /// 참조의 참조를 구현한다.
    class Adapter: Target {
        /// 기존 인터페이스를 갖는 클래스
        private let adaptee: Adaptee
        
        init(_ adaptee: Adaptee) {
            self.adaptee = adaptee
        }
        
        override func request() -> String {
            "Adapter: Adapting and delegating to adaptee"
            + adaptee.specific_request()
        }
    }
    
}
/// 장점
/// 1. 호환성을 유지하면서 기존의 코드를 재사용할 수 있다.
/// 2. 코드의 유연성을 높옂부며, 클래스 간의 결합도를 낮출 수 있다.
/// 3. 기존 코드를 수정하지 않고도 새로운 인터페이스를 추가할 수 있다.
///
/// 단점
/// 1. 어댑터 패턴을 사용하면 중간 인스턴스 삽입으로 성능이 떨어질 수 있다.
/// 2. 기존 코드와 새로운 코드 간의 차이점을 명확히 이해하고 구현해야해서 구현이 어려울 수 있다.
