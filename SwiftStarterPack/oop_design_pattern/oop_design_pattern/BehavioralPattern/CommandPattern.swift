//
//  CommandPattern.swift
//  oop_design_pattern
//
//  Created by Greem on 4/9/25.
//

import Foundation

/// 하나의 커멘드 명령어 등록
protocol Command {
    func execute()
}

extension Behavior {
    /// 특정 작동을 시키는 객체
    struct Light {
        func on() {
            print("Light On")
        }
        
        func off() {
            print("Light Off")
        }
    }
    
    /// 특정 작동을 시키는 객체
    struct AirConditioner {
        func on() {
            print("Air Conditioner On")
        }
        
        func off() {
            print("Air Conditioner Off")
        }
    }
    
    /// 객체의 특정 메서드를 커멘드 명령어의 객체로 제작
    struct LightOnCommand: Command {
        private let light: Light
        
        init(light: Light) {
            self.light = light
        }
        
        func execute() {
            light.on()
        }
    }
    
    /// 객체의 특정 메서드를 커멘드 명령어의 객체로 제작
    struct LightOffCommand: Command {
        private let light: Light
        
        init(light: Light) {
            self.light = light
        }
        
        func execute() {
            light.off()
        }
    }
    
    /// 객체의 특정 메서드를 커멘드 명령어의 객체로 제작
    struct AirConditionOnCommand: Command {
        private let airCondition: AirConditioner
        
        init(airCondition: AirConditioner) {
            self.airCondition = airCondition
        }
        
        func execute() {
            airCondition.on()
        }
    }
    
    /// 객체의 특정 메서드를 커멘드 명령어의 객체로 제작
    struct AirConditionOffCommand: Command {
        private let airCondition: AirConditioner
        
        init(airCondition: AirConditioner) {
            self.airCondition = airCondition
        }
        
        func execute() {
            airCondition.off()
        }
    }
    
    enum CommandError: Error {
        case noExistCommand
    }
    
    /// 커멘드 컨트롤러는 커멘드로 제작된 작동을 수행
    /// 각각의 동작에 대한 의존성 분리, setCommand로 정책 변경 가능
    class CommandController {
        private var command: Command?
        
        func setCommand(_ command: Command) {
            self.command = command
        }
        
        func doAction() throws {
            guard let command else {
                throw CommandError.noExistCommand
            }
            command.execute()
        }
    }
    
    func executeCommands() throws {
        let command = CommandController()
        
        let light = Light()
        let airConditioner = AirConditioner()
        
        let lightOnCommand = LightOnCommand(light: light)
        let lightOffCommand = LightOffCommand(light: light)
        let airConditionOnCommand = AirConditionOnCommand(airCondition: airConditioner)
        let airConditionOffCommand = AirConditionOffCommand(airCondition: airConditioner)
        
        command.setCommand(lightOnCommand)
        try command.doAction()
        command.setCommand(lightOffCommand)
        try command.doAction()
        command.setCommand(airConditionOnCommand)
        try command.doAction()
        command.setCommand(airConditionOffCommand)
    }
}
