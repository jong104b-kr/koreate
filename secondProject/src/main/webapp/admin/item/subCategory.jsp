<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<select id="itemSubCategory" name="itemSubCategory">
	<option value="">=중분류 선택=</option>
	<c:forEach var="c" items="${v }">
	<option value="${c.cateId}" <c:if test="${cateSubId == c.cateId }">selected</c:if>>${c.cateName}</option>
	</c:forEach>
</select>
