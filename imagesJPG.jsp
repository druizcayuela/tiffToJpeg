<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:forEach var="image" items="${images}">
  <tr>
  	<td style="width:15%"></td> 
  	<td style="width:70%">
  		<div  align="center">
  			<img src="data:image/png;charset=utf-8;base64, ${image}">
  		</div>
  	</td>
  	<td style="width:15%"></td>
  </tr>
</c:forEach>
