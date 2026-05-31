<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg navbar-light">
    <a class="navbar-brand" href="/team3/"><h1 class="gnbTitle">학사관리 시스템</h4></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/team3/student/studentCheck.do">학생</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/team3/professor/professorCheck.do">교수</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/team3/staff/staffStudentList.do">교직원 학생관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/team3/staff/staffProfessorList.do">교직원 교수관리</a>
            </li>
          <%--   <li class="nav-item">
                <a class="nav-link" href="http://localhost/team3/prog.html">스타일가이드</a>
            </li> --%>
        </ul>
    </div>
</nav>


