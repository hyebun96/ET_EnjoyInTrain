# :train2: EnjoyInTrain_ET

기차 예매 웹페이지
- 모든 연령의 사용자가 이용하기 편리하게 구성한 예매 시스템
- 여행 프로모션으로 기차 할인과 맞춤 여행 패키지를 제공하는 시스템
<br/>

## 참고사이트
[코레일](http://www.letskorail.com/)
<br/>


## 목차
1. 본인 구현 기능
3. 사용기술
<br/>

## 본인 구현 기능
<< 여행 프로모션 메인>>
1.	프로모션 리스트
  -	구매 수가 높은 인기 여행 상품 리스트
  -	최근 등록된 프로모션 리스트
  -	프로모션 예매 가능 마감 기간이 임박한 상품 리스트
  -	구매 수가 높은 프로모션은 제목 옆에 ‘주문 폭주’ 이펙트 효과 부여

<< 여행 프로모션 >>
1.	여행 프로모션 리스트
  -	여행 프로모션 상품 리스트 지역별 조회
2.	여행 프로모션 상세
  -	기차를 시간대별로 선택 가능 
  -	달력을 통해 여행 날짜 선택 가능
3.	여행 프로모션 예약
  -	여행 프로모션 기차 좌석 선택
  -	이용인원 분류선택
  -	여행 프로모션 간단 조회 및 예약 가능
4.	여행 프로모션 예약 완료 및 결제
  -	3일안에 미결제시 예약 내역 삭제 
  -	오픈 API 카카오페이 결제
5.	여행 프로모션 예약 및 결제 리스트 조회 
  -	회원 여행 프로모션 예약 리스트 조회 가능
  -	여행 프로모션 미결제시 리스트를 통해 결제 가능

<< 매출통계 >>
1.	프로모션 통계
  -	지역별, 프로모션별에 따른 프로모션 매출 통계
  -	지역별은 발급건수에 대한 비율 통계
  -	프로모션별은 협력업체의 상환비율을 전체금액에서 차감
  -	프로모션별은 각 프로모션 예약금액 합산 

<< 여행 프로모션 관리 >>
1.	프로모션 리스트
  -	프로모션 생성/수정/삭제 가능
2.	프로모션 생성
  -	프로모션 이용 시 예매가능한 열차 선택
  -	여행은 다중 이미지로 업로드 가능
  -	가는 열차/오는 열차 출발/도착역 선택, 옵션 상품가격 자동으로 프로모션 금액 산출


3.	프로모션 예약 및 결제 리스트
  -	프로모션 예약 및 결제 리스트 조회
  -	관리자는 예약 내역을 삭제/취소 가능

<< FAQ >>
1.	자주 묻는 질문 리스트
2.	질문 등록, 수정, 삭제

<< Q&A>>
1.	질문과 답변 리스트
2.	사용자는 질문 등록, 질문 수정, 질문 삭제
3.	사용자는 질문 등록에서 선택한 카테고리의 FAQ를 4리스트를 바로 볼 수 있음
4.	관리자는 질문에 대한 답변 등록, 답변 수정, 답변삭제
