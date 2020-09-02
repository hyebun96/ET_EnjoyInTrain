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
2. 특징
3. 사용기술
<br/>

## 1. 본인 구현 기능

### << 여행 프로모션 메인>>

![image](https://user-images.githubusercontent.com/58923654/91658024-dd16ae80-eb00-11ea-8863-c422de08c7c2.png)


1.	프로모션 리스트
    -	구매 수가 높은 인기 여행 상품 리스트
    -	최근 등록된 프로모션 리스트
    -	프로모션 예매 가능 마감 기간이 임박한 상품 리스트
    -	구매 수가 높은 프로모션은 제목 옆에 ‘주문 폭주’ 이펙트 효과 부여
<br/>

### << 여행 프로모션 >>

![image](https://user-images.githubusercontent.com/58923654/91991611-11db6d80-ed6e-11ea-8bf6-d7bbf22d3a33.png)
![image](https://user-images.githubusercontent.com/58923654/91991614-13a53100-ed6e-11ea-9899-c7249f08fe45.png)



1.	여행 프로모션 리스트
    - 	여행 프로모션 상품 리스트 지역별 조회   

![image](https://user-images.githubusercontent.com/58923654/91991669-23bd1080-ed6e-11ea-8336-1dba1722e932.png)
![image](https://user-images.githubusercontent.com/58923654/91991672-24ee3d80-ed6e-11ea-84a8-45e66a6dc851.png)


2.	여행 프로모션 상세
    -	기차를 시간대별로 선택 가능 
    -	달력을 통해 여행 날짜 선택 가능

![image](https://user-images.githubusercontent.com/58923654/91991679-27e92e00-ed6e-11ea-8c8e-aa3881ecb6c2.png)
![image](https://user-images.githubusercontent.com/58923654/91991684-29b2f180-ed6e-11ea-9ac3-77eeab0022a1.png)

    
3.	여행 프로모션 예약
    -	여행 프로모션 기차 좌석 선택
    -	이용인원 분류선택
    -	여행 프로모션 간단 조회 및 예약 가능
    
![image](https://user-images.githubusercontent.com/58923654/91991755-418a7580-ed6e-11ea-940a-db8768070215.png)

    
4.	여행 프로모션 예약 완료 및 결제
    -	3일안에 미결제시 예약 내역 삭제 
    -	오픈 API 카카오페이 결제
    
![image](https://user-images.githubusercontent.com/58923654/91991781-4c450a80-ed6e-11ea-99f0-c877099af502.png) 

    
5.	여행 프로모션 예약 및 결제 리스트 조회 
    -	회원 여행 프로모션 예약 리스트 조회 가능
    -	여행 프로모션 미결제시 리스트를 통해 결제 가능
<br/>


### << 매출통계 >>

![image](https://user-images.githubusercontent.com/58923654/91992014-98904a80-ed6e-11ea-8609-d601fda8686f.png)


1.	프로모션 통계
    -	지역별, 프로모션별에 따른 프로모션 매출 통계
    -	지역별은 발급건수에 대한 비율 통계
    -	프로모션별은 협력업체의 상환비율을 전체금액에서 차감
    -	프로모션별은 각 프로모션 예약금액 합산 
<br/>


### << 여행 프로모션 관리 >>
1.	프로모션 리스트
    -	프로모션 생성/수정/삭제 가능
2.	프로모션 생성
    -	프로모션 이용 시 예매가능한 열차 선택
    -	여행은 다중 이미지로 업로드 가능
    -	가는 열차/오는 열차 출발/도착역 선택, 옵션 상품가격 자동으로 프로모션 금액 산출
3.	프로모션 예약 및 결제 리스트
    -	프로모션 예약 및 결제 리스트 조회
    -	관리자는 예약 내역을 삭제/취소 가능  
<br/>

### << FAQ >>
1.	자주 묻는 질문 리스트
2.	질문 등록, 수정, 삭제
<br/>

### << Q&A>>
1.	질문과 답변 리스트
2.	사용자는 질문 등록, 질문 수정, 질문 삭제
3.	사용자는 질문 등록에서 선택한 카테고리의 FAQ를 4리스트를 바로 볼 수 있음
4.	관리자는 질문에 대한 답변 등록, 답변 수정, 답변삭제
<br/>


## 2. 특징
- Java 코드에서 자주 사용되는 변수는 인터페이스에 상수로 선언하여 참조
- Spring의 MVC 패턴을 이용하여 AOP, 트랜잭션 처리, DI를 사용
- Spring의 DI 패턴을 적용하여 의존관계를 최소화
- Tiles 3의 템플릿 엔진을 이용하여 레이아웃이 반복적으로 사용되는 구간의 중복을 최소화
- Ajax를 이용하여 비동기 통신으로 데이터 요청을 최소화.
- 웹 표준 마크업을 지향하고자 HTML5, CSS3를 이용하여 웹 문서를 작성
- 카카오페이, 카카오 맵을 이용하여 Open API를 사용

## 3. 사용 기술

- Front-end : HTML5, CSS3, JS, jQuery, AJAX<br/>
- Back-end : Oracle, Java<br/>
- Tiles 3<br/>
- version : Spring 4.3.27, Oracle 18c
- Tools :  Sql Developer, STS 3.9<br/>
- Mybatis 3<br/>
- DB 모델링 : eXERD<br/>
- Git & Github<br/>


