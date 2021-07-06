//
//  Config.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/02.
//

//신차가격 700만 원의 모터바이크를 중고로 구매했고
//최초 등록 후 1년이 지났다면 실제 거래가격이 아닌 0.562%를 적용하여
//7,000,000×0.562=3,934,000이라는 가치가 차량 가격으로 책정되며
//이 금액과 신고금액 중 높은 금액을 기준으로 세금이 매겨진다. 취등록세는 0.05이므로,
//3,934,000×0.05=196,700이라는 값이 나오기 때문에 19만 6천7백 원이다.
//실제 적용은 차량 모델 별 과표에 따라 매겨지므로 소폭의 차이가 있을 수 있다.

//125cc 미만은 취득가의 2%
//125cc 이상은 취득가의 5%

import UIKit

struct Config {
    //중고차 과오기준 오율표에 따른 기준.
    //잔존가치 구하는 것.
    enum Rate {
        case newBike    //= 1.0     신차
        case lessOneYear//= 0.703   1년미만
        case oneYear    //= 0.562   1년
        case twoYear    //= 0.464   2년
        case threeYear  //= 0.316   3년
        case fourYear   //= 0.215   4년
        case fiveYear   //= 0.147   5년
        case sixYear    //= 0.1     6년
    }
    
    static var rate: Rate = .newBike
    
    static var bikeRate: Double {
        get{
            switch rate {
            case .newBike:
                return 1.0
            case .lessOneYear:
                return 0.703
            case .oneYear:
                return 0.562
            case .twoYear:
                return 0.464
            case .threeYear:
                return 0.316
            case .fourYear:
                return 0.215
            case .fiveYear:
                return 0.147
            default:
                return 0.1 //sixYear
            }
        }
    }
    
}
