<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 검색</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String searchName = request.getParameter("name");	

	String sql = "SELECT * FROM student_tbl WHERE name'"+searchName+"'"; // 모든 회원의 목록을 가져오기
	
	
	String driverName = "com.mysql.jdbc.Driver"; // my sql 에서 제공하는 드라이버 이름 고정 값 - 오타 발생할 경우 에러 발생함 : com.mysql.jdbc.Driver
	String url = "jdbc:mysql://localhost:3306/school_cb";//DB가 설치된 주소 - 연결할 DB의 스키마를 지정 : school_db
	String username = "root"; // 관리자 계정 이름
	String password = "12345"; // 관리자 계정 비밀번호
	
	Connection conn = null;//DB와의 연결 통로 확보
	Statement stmt = null;//sql 문 실행
	ResultSet rs = null;//select 문 실행시 DB에서 반환해주는 결과 레코드를 받기 휘한 자료타입을 준비
	
	try {
		Class.forName(driverName); // mt sql 드라이버 불러오기
		conn = DriverManager.getConnection(url, username, password); // DB와의 커넥션 생성
		stmt = conn.createStatement();
				
	 	rs = stmt.executeQuery(sql);
	 	
	 	//ArrayList memberList = new ArrayList();
	 	//memberList = null;
	 	
	 	System.out.println(rs);
	 	while(rs.next()) {
	 		int sno = rs.getInt("sno");
	 		String name = rs.getString("name");
	 		String dept = rs.getString("dept");
	 		if (name.equals (null)){
	 			out.println("검색하신 회원은 없는 회원 입니다.");

	 		} else {
	 			System.out.println(sno);
	 			out.println(sno + " / " + name + " / " + dept + "<br><br>");
	 		}
	 		
	 	}
	 	
	} catch(Exception e){
		out.println("DB연결실패! 회원목록불러오기 실패!");
		e.printStackTrace();
	} finally {
		try {
			if(stmt != null){
				stmt.close();
			}
			if(conn != null){
				conn.close();
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	}	
	%>

</body>
</html>