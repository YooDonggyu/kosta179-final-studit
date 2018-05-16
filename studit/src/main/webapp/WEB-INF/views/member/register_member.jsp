<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<div class="col-sm-3" ></div>
	<div class="col-sm-6">
            <form class="form-horizontal" role="form">
                <h2>STUD-IT 회원가입</h2>
                
                <div class="form-group">
                    <label for="firstName" class="col-sm-3 control-label">이메일</label>
                    <div class="col-sm-9">
                        <input type="email" id="memberEmail" name="memberEmail" placeholder="Full Name" class="form-control" autofocus>
                        <!-- <span class="help-block">Last Name, First Name, eg.: Smith, Harry</span> -->
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label">비밀번호</label>
                    <div class="col-sm-9">
                        <input type="password" id="password"  name= "password" placeholder="password" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">비밀번호 확인</label>
                    <div class="col-sm-9">
                        <input type="password" id="passwordCheck"  name="passwordCheck" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">이름</label>
                    <div class="col-sm-9">
                        <input type="text" id="name" name="name" placeholder="홍길동" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">주소</label>
                    <div class="col-sm-9">
                        <input type="text" id="addr" name="addr" placeholder="검색 후 상세주소를 입력하세요" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">전화번호</label>
                    <div class="col-sm-9">
                        <input type="text" id="name" name="name" placeholder="01012345678" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">비밀번호 힌트</label>
                    <div class="col-sm-9">
                        <input type="text" id="passwordHint" name="passwordHint" placeholder="자주 가는 곳은?" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">비밀번호 정답</label>
                    <div class="col-sm-9">
                        <input type="text" id="passwordAnswer" name="passwordAnswer" placeholder="studit" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="birthDate" class="col-sm-3 control-label">프로필 사진</label>
                    <div class="col-sm-9">
                        <input type="file" id="picPath" name="picPath" class="form-control">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox">I accept <a href="#">terms</a>
                            </label>
                        </div>
                    </div>
                </div> <!-- /.form-group -->
                
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </div>
                </div>
            </form> <!-- /form -->
        </div> <!-- ./container -->
        <div class="col - sm- 3" ></div>