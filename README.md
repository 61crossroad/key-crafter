## key-crafter

'키크래프터'는 기계식 키보드와 관련 주변기기를 판매하는 온라인 쇼핑몰입니다.
아래 링크에서 테스트 가능합니다.

http://13.209.232.233:8080/


#### 테스트 계정
* 아이디/비밀번호 : aaa/aaaa (일반 유저)

* 아이디/비밀번호 : test/test (운영자)

직접 계정을 만들어서 테스트도 가능합니다.


## 목차
[1.기능 설명](#기능-설명)

[2.개발 환경](#개발-환경)

[3.데이터베이스 erd](#데이터베이스-erd)

[4.프로젝트의 기본 구조](#프로젝트의-기본-구조)

[5.http 및 rest api 구현](#http-및-rest-api-구현)

[6.스프링 시큐리티](#스프링-시큐리티)

[7.파일 업로드](#파일-업로드)

[8.카테고리와 댓글의 계층 알고리즘](#카테고리와-댓글의-계층-알고리즘)

[9.aws와 배포](#aws와-배포)

[10.차후 개선 사항](#차후-개선-사항)

### 기능 설명
---
운영자는 일반 유저의 권한과 고유의 권한을 함께 가집니다.

관리자는 일반 유저, 운영자의 권한과 고유의 권한을 다 가집니다.

#### 1.일반 유저
* 회원: 가입, 정보 수정
* 상품: 검색, 조회, 장바구니에 추가, 주문 요청
* 상품 댓글: 조회, 작성, 수정, 삭제
* 장바구니: 상품 수량 변경, 삭제, 주문 요청
* 주문: 주문 내역 조회, 주문 입력, 수정

#### 2.운영자
* 상품: 등록, 수정, 삭제
* 카테고리: 등록, 수정, 삭제
* 주문: 모든 회원의 주문 검색과 조회, 수정

#### 3.관리자
* 회원: 모든 회원 정보 조회, 수정, 권한 변경

### 개발 환경
---
#### 1.Back-end

* Java 8

* Java Spring Framework 5.0.7

* Mybatis 3.4.6 (Mybatis-Spring 1.3.2)

* HikariCP 2.7.8 (데이터베이스 커넥션 풀)

* Oracle 11g R2

* Mariadb 10.4/10.3


#### 2.Front-end

* HTML5 + CSS3

* Bootstrap

* Javascript + JQuery(3.2.1)


### 데이터베이스 erd
---
로컬에서는 Oracle 11g R2 버전으로 데이터베이스 구조와 쿼리를 만들었지만,

배포를 준비하는 과정에서 AWS 프리티어가 제공하는 MariaDB에 맞춰 변환했습니다.

아래 그림은 MySQL Workbench로 작성한 ERD입니다.

![KeyCrafter ERD](https://upload-kc.s3.ap-northeast-2.amazonaws.com/KeyCrafter_ERD_fin.png)

##### 테이블 설명
---
1. member : 회원 정보
2. member_auth : 회원의 권한 (스프링 시큐리티)
3. persistent_logins : 스프링 시큐리티의 principal, authorize, authentication 등 여러 기능을 이용하기 위한 테이블
4. category : 카테고리
5. product : 상품 정보
6. product_attach : 상품의 이미지 파일 정보
7. product_reply : 상품의 후기(댓글) 정보
8. order_info : 주문 정보
9. order_product : product와 order_info를 1대다로 연결하기 위한 테이블
10. order_status : 입금 대기, 배송 준비 중 등 주문 상태를 가지고 있는 테이블

### 프로젝트의 기본 구조
---
스프링 MVC 모델2 계층을 따라서 구성하였습니다.

![structure](https://upload-kc.s3.ap-northeast-2.amazonaws.com/structure-1.png)

* 기본적으로 뷰 페이지는 JSP로 생성하지만 동적인 액션은 Javascript/JQuery로 구현했습니다.
* 컨트롤러는 request에 관해 간단한 전처리나 response 데이터에 대한 판단, 뷰에 response를 전달합니다.
스프링 시큐리티의 @PreAuthorize 어노테이션으로 회원/비회원간, 일반유저/운영자의 액세스를 구분합니다.
* 서비스 계층은 Interface와 이를 구현한 Class의 느슨한 결합으로 설계하였고, 요청에 대한 전반적인 작업을 담당합니다.
요청을 처리하기 위해 여러 테이블에 액세스 하는 경우 @Transactional 어노테이션을 이용해서 트랜잭션을 적용했습니다.
(상품을 등록 할 경우 product, product_attach, product_reply에 모두 데이터를 만듭니다.)
* 쿼리는 테이블마다 xml로 작성하였고, 페이징과 검색 처리를 위해 Mybatis의 다양한 기능을 이용해 동적으로 쿼리를 생성합니다.

### http 및 rest api 구현
---
클라이언트와 서버의 통신은 전통적인 HTTP와 JQuery AJAX를 이용한 RESTful API를 상황에 따라 사용하였습니다.
그 중심에 있는 컨트롤러는 다음과 같이 나눠져 있습니다.
(REST도 HTTP프로토콜을 이용한 통신이지만 편의를 위해 HTTP/REST로 나눠서 표기합니다.)

1. Cart : 장바구니 (HTTP + REST)
2. Category : 카테고리 (전체 카테고리를 수정하는 기능만 HTTP, 나머지는 REST)
3. Member : 회원 가입, 조회, 변경 등 (회원 가입 폼에서 중복 항목 검사만 REST로 구현)
4. Order : 주문 (HTTP)
5. Product : 상품 CRUD (HTTP)
6. ProductReply : 상품 페이지의 댓글 (뷰 전환을 하지 않아야하고, 동시에 여러 댓글이 달리는 경우 즉각적인 반응을 위해 비동기 방식인 REST만 이용)
7. UploadController : 파일 업로드 (REST)

### 스프링 시큐리티
---
User를 상속한 CustomUser 도메인과 UserDetailsService를 상속한 CustomUserDetailsService를 구현하였습니다.

권한은 'ROLE_ADMIN', 'ROLE_MEMBER', 'ROLE_USER'입니다.

1.ROLE_ADMIN : 최고 관리자로서 서비스에 관한 모든 권한을 가집니다.

2.ROLE_MEMBER : 운영자이며 다른 회원의 권한을 수정할 수 없는 제약이 있습니다.

3.ROLE_USER : 일반 고객입니다.

### 파일 업로드
---
AWS SDK for Java를 이용해서 AWS S3 스토리지 서비스에 업로드하도록 구현했습니다.

1. 파일명이 중복되는 것을 막기 위해 파일명에 UUID를 덧붙였습니다.
2. 파일 저장 위치는 년/월/일 계층의 폴더로 나눠서 한 폴더에 너무 많은 파일을 넣지 않도록 했습니다.
3. 상품 사진은 원본, 중간 크기, 작은 크기가 필요했기 때문에 Thumbnailator 라이브러리를 이용해서 섬네일을 만들었습니다.


### 카테고리와 댓글의 계층 알고리즘
---
reference/parent와 sequence, depth 파라미터 등을 이용한 연결 리스트는 직관적으로 떠올려보기는 쉽습니다.
하지만 여러 예외 처리를 위해 코드가 지저분해지고, 유연하게 변형하기가 어렵다고 생각했습니다.

그래서 다른 계층형 자료구조를 찾던 중 아래와 같은 'Nested Set Model'을 발견해서 카테고리와 댓글에 모두 적용했습니다.

http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/

![nested set diagram](http://mikehillyer.com/media//nested_numbered.png)

![nested set tree](http://mikehillyer.com/media//numbered_tree.png)

간단히 요약하자면, 하위 계층은 상위 계층의 부분 집합으로 표현할 수 있기 때문에 집합을 이용해서 트리를 구성할 수 있었습니다.
이런 집합 관계는 각 노드가 갖고 있는 left, right 값으로 구분합니다.

위 그림에 잘 나타나 있듯이 경계값(left, right)이 2 ~ 9 인 TELEVISION의 하위 계층은, 2와 9 사이가 자신의 경계인 TUBE, LCD, PLASMA입니다.

또한 계층의 깊이는 자신을 포함하는 부모 노드의 수를 세어서 구할 수 있습니다.
TUBE의 경계 3 ~ 4를 포함하는 노드는 TELEVISION(2 ~ 9)와 ELECTRONICS(1 ~ 20) 두 개 이므로 TUBE의 깊이는 2가 됩니다.

노드를 추가할 때는 추가될 노드의 부모와 더 오른쪽에 있는 노드들의 right 값을 +2만 해주면 됩니다.

예를 들어 OLED를 TELEVISION 하위, PLASMA의 형제로 넣으려고 한다면 PLASMA의 right 값인 8보다 right가 큰 노드들의 값을 모두 2씩 증가시킵니다.

(경우에 따라 left와 right를 모두 증가시키는 노드도 있습니다.)

이 과정 이후에 2[TELEVISION]11과 7[PLASMA]8 사이에 9와 10이 비어있으므로, 9[OLED]10을 생성해서 넣을 수 있습니다.

![Nested Set Model, Create](https://upload-kc.s3.ap-northeast-2.amazonaws.com/nestedsetcrud.png)

삭제는 반대로 타겟 노드를 삭제하고 그 노드의 넓이(right - left + 1)만큼 기존 노드들의 left 또는 right 값을 줄여서 트리를 유지합니다.

예를 들어서 10[PORTABLE ELECTRONICS]19를 삭제한다면, left와 right가 10 ~ 19 사이에 있는 노드가 모두 PORTABLE ELECTRONICS의 자식이므로 간단한 쿼리와 빠른 속도를 서브트리를 삭제할 수 있습니다.

다음으로 10 ~ 19가 모두 사라졌으므로 그 width인 (19 - 10 + 1 = 10)만큼 ELECTRONICS의 right값을 줄입니다.

이런 과정을 통해 Nested Set을 계속 유지합니다.

### aws와 배포
---
AWS 프리티어를 이용했습니다.

* EC2 - 아마존 리눅스 AMI

* RDS - MariaDB 10.3

* S3 - 스토리지 서비스

EC2에 Apache Tomcat 9.0을 설치해서 웹서버로 사용 중입니다.

### 차후 개선 사항
---
웹 개발을 시작하고 처음으로 만든 프로젝트이지만, 기성 쇼핑몰 같은 디테일을 구현하고 싶었습니다.
하지만 현실적인 상황도 고려하지 않을 수 없어서 현재 완성도에서 잠시 멈추기로 결정했습니다.
마지막으로 아쉬움이 남는 개선사항들을 남겨두고자 합니다.

1. SSH 인증서를 통한 https 적용
2. 상용 결제 PG API 연동
3. OAuth 2.0을 이용한 소셜 로그인
4. 회원에게 이벤트가 발생했을 때 자동으로 이메일이나 메시지를 보내는 기능
