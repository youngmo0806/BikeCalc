//
//  Config.swift
//  BikeCalc
//
//  Created by hklife_mo on 2021/07/02.
//

//신차 1.0
//1년미만 0.703
//1년 0.562
//2년 0.464
//3년 0.316
//4년 0.215
//5년 0.147
//6년 0.1

//신차 가격 700만원의 모터바이크를 중고로 구매했고 최초 등록후 1년이 지났다면 실제 거래가격이 아닌 0.562를 적용하여
//7,000,000 * 0.562 = 3,934,000 이라는 가치가 차량 가격으로 책정되며 이금액과 신고금액 중 높은 금액을 기준으로 세금이 매겨진다.
//취등록세는 0.05 이므로, 3,934,000 * 0.05 = 196,700 이라는 값이 나오기 때문에 19만 6천7백원이다.
//실제 적용은 차량 모델 별 과표에 따라 매겨지므로 소폭의 차이가 있을 수 있다.

import UIKit

struct Config {

    enum Rate {
        case newBike    //= 1.0
        case lessOneYear// = 0.703
        case oneYear    //= 0.562
        case twoYear    //= 0.464
        case threeYear  //= 0.316
        case fourYear   //= 0.215
        case fiveYear   //= 0.147
        case sixYear    //= 0.1
    }
}
