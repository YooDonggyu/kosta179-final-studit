# kosta179-final-studit

# 1. 팀 회의

## 1.1. 보고

+ <u>지각</u> : SNS를 통해 팀원에게 즉시 알림
+ <u>결석</u> : 결석 사유와 함께 최소 이틀 전 공지(단, 응급상황의 경우 예외)
+ <u>특정 회의 불참</u> :  예정된 회의 시간에 불참할 경우 사유를 기록(보고서)

## 1.2. 일정

+ 아침 
  + 9시 15분 ~ 9시 45분 (+10)
  + 오전 수업이 있는 날은 점심 회의로 대체
  + 개인 브리핑 사항(전원) 
    1. 전 날과 변동사항
    2. 특이사항(이슈사항)
    3. 궁금한 점
  + <u>아침 회의 미 참석자</u>는 개인 브리핑 사항을 SNS로 보고
+ 점심
  + 11시 45분 ~ 12시 15분 
  + 매일 있는 회의가 아님 - 팀원 개인이 필요시 미리 공지 후 개최 
+ 저녁
  + 18시 00분 ~ 18시 30분 (+10)
  + 개인 브리핑 사항(전원)
    1. 아침 회의 이후 진행사항 
    2. 특이사항(이슈사항)
    3. 향 후 일정 보고
    4. 궁금한 점
  + 저녁 회의 미 참석자는 개인 브리핑 사항을 SNS로 보고
+ 추가 회의
  + 추가 회의가 필요하다고 생각되는 팀원은 SL에게 보고 후 SL이 의견수립
  + 추가 회의 인원은 최소한의 팀원(꼭 필요한 팀원)으로 구성
  + 추가 회의시 DL이 없으면 <u>DL 대리인</u>을 정해 회의록 작성(사진 포함)



# 2. Code Convention


| 용어 |  의미  |                             대체                             |              예              |
| :--: | :----: | :----------------------------------------------------------: | :--------------------------: |
|  C   | Create |                           Register                           | createFile<br>registerMember |
|  R   |  Read  | Get : 파라미터가 없는 메서드<br>Find : 파라미터가 있는 메서드 |        readAllMember         |
|  U   | Update |                                                              |       updateMemberById       |
|  D   | Delete |                                                              |       deleteMemberById       |

+ 기능이 뚜렷한 경우는 CRUD에서 제외  : Login / Logout 등





## 2.1. Controller

### 2.1.1. 파일 명칭

+ 대상 이름을 활용해서 작성 
  + 예시
    + 대상 : Member | 파일 명 : MemberController
    + 대상 : Stock : | 파일 명 : StockController
+ 특수 Controller
  + **AjaxViewController** : Ajax를 사용할 때 사용(ResponseBody)


### 2.1.2. *.do 

+ CRUD

+ Camel 표기법 이용 : registerMember.do, findMemberById.do

+ 기본적으로 메소드 명과 일치하여 사용

  + ajax는 맨뒤에 `Ajax`를 붙임 : idCheckAjax.do


  + 메소드 명 : findProductListByMaker(String maker) 
    *.do 명 : findProductListByMaker.do

+ <u>Redirect</u> 목적인 url-pattern은 마지막에 `View`를 추가
  + registerMeber.do -> registerMemberView.do
  + updateProductHit.do -> updateProductHitView.do





## 2.2. Model

### 2.1. Service 명

+ 서비스의 주 대상을 이용(기능 단위의 핵심 대상)
  + 예시
    + 대상 : Member | Service 명 : MemberSerivceImpl, MemberService
    + 대상 : Product | Service 명 : ProductServiceImpl, ProductService



### 2.2.2. DAO, VO 명

- 주 대상을 이용(핵심 대상)
  - 예시
    - 대상 : Member | DAO명 : MemberDAO | VO명 : MemberVO
    - 대상 : Product | DAO명 : ProductDAO | VO명 : ProductVO



### 2.2.3. XML(Mapper) 명

+ 주 대상과 동일(핵심 대상)
  + 예시
    + 대상 : Member | Mapper명 : Member.xml
    + 대상 : Product | Mapper명 : Product.xml

+ XML의 sql ID

  + Call한 메서드와 동일

    + 예(sql ID = findMemberById, mapper = member)

      ```java
      	...(중략)
      	@Override
          //call한 메서드 : findMemberById(String id)
      	public MemberVO findMemberById(String id){
              //member의 mapper 안에 있는 sql ID = findMemberById를 실행 
          	return template.selectOne("member.findMemberById", id);
      	}
      	...(중략)
      ```



## 2.3. View

+ 주 대상으로 Directory 설정

  + Member, Board, template 등

+ 기본 형식 

  -  동사(혹은 명사, 형용사) _ Directroy명_(구체적 대상-필요시).jsp
  - Template : header / footer / left / right / layout 

  > Member Directory
  >
  > > 동사_Directory.jsp  : register_member.jsp 
  > >
  > > 명사_Directory.jsp : list_member.jsp
  > >
  > > 형용사_Directory.jsp  : detail_member.jsp 
  >
  > Board Directory
  >
  > > 명사_Directory.jsp : list_board.jsp
  > >
  > > 동사_Directory.jsp : update_board.jsp, delete_board_study.jsp

+ 특정 형식 : 기능_상태.jsp

  > login 기능
  >
  > > login_fail.jsp



## 2.4. Package명과 예시

+ org.kosta.프로젝트명.controller : MemberController
+ org.kosta.프로젝트명.model : PagingBean
  + org.kosta.프로젝트명.model.dao : MemberDAOImple, MemberDAO
  + org.kosta.프로젝트명.model.vo : MemberVO, ListVO(페이징)
  + org.kosta.프로젝트명.model.service : MemberServiceImpl, MemberService

+ Test Package & Class

  + package명 : 위와 동일

  + Class 명 : 마지막에 Test를 붙여줌

    > src/main/java
    >
    > > org.kosta.practice.model.service
    > >
    > > > MemberServiceImpl
    >
    > src/test/java
    >
    > > org.kosta.practice.model.service
    > >
    > > > MemberServiceImplTest



## 2.5. 들여쓰기, 괄호

### 2.5.1. java

+ if문 : 중괄호 모두 작성

  ```java
  int num = 1;
  if(num == 1){      // 한 줄이여도 열고 닫기
      System.out.println("1입니다");
  }else{
      System.out.println("1이 아닙니다");
  }
  ```

+ 들여쓰기 : 단축키 사용해서 맞추기




### 2.5.2. jsp

+ 태그 안의 태그를 작성할 때 태그 단위로 들여쓰기

  ```html
  <body>
      <table>
          <tr>
              <td>여기까지 들여쓰기 3번</td>
          </tr>
      </table>
  </body>

  <c:choose>
      <c:when>
      	when과 otherwise는 태그안의 태그 관계가 아니라 동일 선상
      </c:when>
      <c:otherwise>
      	<c:if>
          	otherwise와 if는 태그안의 태그 관계임으로 들여쓰기로 구분
          </c:if>
      </c:otherwise>
  </c:choose>
  ```


## 2.6. 주석

### 2.6.1. Java

+ **<u>자신이 개발한 코드는 모두 주석 필수</u>** 

+ 적는 법

  + Class

    + 필수요소 : @author, @version
      + @author : 작성자

  + Class  변수

    + 변수 명과 설명

      ```java
      /**
      * MyBatis SQL Method 호출을 위한 template 선언
      */
      @Autowired
      private SqlSessionTemplate template;
      ```

  + 메서드 

    + 요소(author 이외는 선택적)
      + @author, @param, @return, @exception, @see 


+ 예

  ```java
  /**
  * 사용자에 관한 DAO.  
  * 
  * @author 유동규, 변태섭
  * @see (필요시 등록)
  */
  Class MemberDAOImpl extends MemberDAO{
  	/**
  	* MyBatis에서 제공하는 template 사용.
  	*/
      @Autowired
      private SqlSessionTemplate template;

      /**
      * 아이디로 회원 찾기.
      * 입력한 id를 이용하여 id에 해당하는 회원 객체를 구함.
      * 
      * @author 유동규
      * @param id 검색할 id가 파라미터로 전달
      * @return MemberVO(id,password,name,address)
      * @exception (예외 처리 작업을 할 때 작성)
      * @see (참조할 문서가 있으면 작성)
      */
      public MemberVO findMemberById(String id){
          return template.selelctOne("member.findMemberById",id);
      }
  }

  ```

  

### 2.6.2. JSP

+ javaScript, jQuery, Ajax

  + 작성자, 기능요약(한 줄) 및 로직 설명

  + 작성자는 가장 최근의 수정자

  + 단, `$(document).ready()`는 생략

  + 예

    ```javascript
    <script type="text/javascript">
        
        $(document).ready(function(){
        	//작성 : 유동규
        	//기능 : ID 중복 체크
        	//로직 : 사용자의 아이디가 사용가능한지 Ajax를 통해 검증한 후
        	//		사용 가능하면 hidden에 true 설정. 아니면 false
            $.ajax({
            	type : "post",
                url : "idCheckAjax.do",
                data : "id="+$("#id").val(),
                success:function(result){
                    if(result == "true"){
                        $("#flag").val("true");
                    }else{
                        $("#flag").val("false");
                    }
                }
            })
        	    
        
    	})
        
    </script>
    ```

    



### 2.6.3. XML

+ Mapper

  + 정의(한 줄로 작성), 매개별수, return, resultMap(필요시)

  + 예

    ```xml
    <!--
    	사용자의 ID로 ID에 해당하는 정보를 찾는다.
    	@param id 사용자 ID
    	@return memberVO ID에 해당하는 memberVO
    -->
    <select id="findMemberById" resultType="memberVO">
    	select id, password, name, address 
        from member
        where id = #{value}
    </select>

    ```

+ SqlSessionConfig.xml, spring-web.xml, spring-model.xml은 생략








# 3. Git Convention

## 3.1. Commit

### 3.1.1 Commit Type

+ Type
  + 코드에 관련된 Type
    + feat : 새로운 기능
    + refactor : 기능 수정(보완)
    + fix : 버그 수정
    + test : test 코드 추가 및 수정

  + 그 외에 관련된 Type

    + docs : 새로운 문서 혹은 문서 수정
    + style : 코드 의미에 영향이 없는 것이 변경(예: 띄어쓰기, 들여쓰기,  세미콜론 등)
    + chore : 소스나 테스트 파일, style 이외의 것 변경
    + revert : 이전의 commit으로 되돌아 감

+ 사용

  + 사용 양식

    > type : 한 줄 요약
    >
    > 변경사항 설명
    >
    > Resolves : 이슈관리대장 번호
    >
    > See also : 관련 이슈 번호

  + 사용 예

    > feat : 로그인 기능 commit
    >
    > 
    >
    > MemberDAO, MemberDAOImpl : 메소드(findMemberById, login) 추가
    >
    > login_fail : 로그인 실패시 alert을 위한 view 추가
    >
    > 
    >
    > Resolves : #1
    >
    > See alse : #2, #3



### 3.1.2. 이슈관리 대장 등록

+ 제목 : 첫 번째는 Type으로 구분

  + Type 종류

    + feat : 기능
    + error : 에러 발생 공유
      - error관련 이슈는 상황을 자세히 설명 = 자신이 어떻게 코드를 작성했는지 설명
      - error 해결 시 댓글로 해결방법 작성
    + conflict : commit, push, merge 등 git에 대한 이슈등록
    + etc : 그 외
    + 종류는 타협으로 더 추가 가능

+ 사용 예

  + > [feat] 로그인 기능 구현

    

  + > [error] ID 중복체크를 위한 Ajax에서 오류
    >
    > > ajax 사용을 위해 아래와 같이 작성
    > >
    > > type : "get",
    > >
    > > url : "idCheckAjax.do"
    > >
    > > data : "id="+$("#id").text(),
    > >
    > > success:function(result){
    > >
    > >    (생략)
    > >
    > > }
    > >
    > > 
    > >
    > > //해결 한 후 댓글
    > >
    > > > data : "id="+$("#id").text() 에서 text()가 아닌 val()로 변경

    





# 4. JavaScript 선언 위치(보류)

참고 : [붉디붉은 피의 고양이's blog- js 선언위치](http://blog.bloodcat.com/191)


