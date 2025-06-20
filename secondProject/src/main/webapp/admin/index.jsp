<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<nav>
<ul>
	<c:if test="${sessionScope.level eq '3' }">
		<li><a href="/admin/">관리자</a></li>
		<li><a href="/">사용자</a></li>
	</c:if>
	<li><a href="/admin/member/list">회원관리</a></li>
	<li><a href="/admin/bbs/list">게시판관리</a></li>
	<li><a href="/admin/category/list">상품입고</a></li>
	<li><a href="/admin/item/list">재고관리</a></li>
	<li><a href="/admin/cart/list">장바구니관리</a></li>
	<li><a href="/admin/order/list">주문관리</a></li>
	<c:choose>
		<c:when test="${sessionScope.id != null && sessionScope.level eq '3' }">
			<li><a href="/member/logout">로그아웃</a></li>
			<!-- <li><a href="/admin/member/update">회원수정</a></li> -->
		</c:when>
		<c:otherwise>
			<li><a href="/member/login">로그인</a></li>
			<li><a href="/member/add">회원가입</a></li>
		</c:otherwise>
	</c:choose>
</ul>
</nav>
<!-- tableContainer -->
<div id="tableContainer">
	<!-- tableRow -->
	<div id="tableRow">
		<section id="drinks">
			<h1>커피</h1>
				<p>하우스 블렌드. 1,500원</p>
				<p>모카 카페 라떼. 2,500원</p>
				<p>카푸치노. 2,000원</p>
				<p>차이티. 1,800원</p>
			<h1>음료</h1>
				<p>
					시골커피 라운지에서 자랑스럽게 출시한 건강에 좋은 음료입니다. 
				</p>
				<p>시원한 녹차. 3,000원</p>
				<p>차가운 산딸기 농축과즙. 3,000원</p>
				<p>블루베리 블리스. 2,500원</p>
				<p>노화방지용 크렌베리 블래스트. 3,500원</p>
				<p>차가운 차이맛 음료. 3,300원</p>
				<p>블랙 브레인 음료. 4,000원</p>
		</section>
		<section id="blog">
		<article>
		<header>
		<h1>시골커피 신제품 추출영상 홍보</h1>
		<time datetime="2023-05-03">5/3/2023</time>
		</header>
		<p>
			약속한 대로 시골커피에서 신제품을 출시하게 된 것을 영광으로 생각합니다.
			이 커피는 여러분이 한 모금 마실 때마다 수익의 3%가 농장으로 돌아가는
			특별한 커피입니다. 저희 새로운 커피에 대한 영상을 확인해 보세요.
		</p>
		<video controls autoplay width="512" height="288" src="/video/newLaunching.mp4"></video>
		</article>
		<article>
		<header>
		<h1>시골커피, 소셜미디어와 만나다!</h1>
			<time datetime="2023-03-12">3/12/2023</time>
		</header>
		<p>
			소셜미디어 열풍이 불어와 이 곳 시골커피에서도 이를 도입하는 중입니다. 
			소셜 미디어에 관해서라면 실제로, 저희 회사에서는 그 어떤 경쟁사보다 앞서 있고, 
			커피 음료와 여러분의 소셜 네트워크를 직접 연결하는, 아주 혁신적인 새 제품 출시를 눈 앞에 두고 있습니다. 
			직접 확인할 필요는 없습니다. 저희는 훨씬 더 앞서 있으며, 
			새 제품과 함께라면 부드럽고 향이 좋은 뜨거운 시골커피 음료를 여러분의 소셜 네트워크와 공유할 수 있을 거에요. 
		</p>
		<p>
			공상과학 영화 같나요? 절대 아닙니다. 
			앞에서 기술한 대로 이미 최종 소셜 네트워크 프로토타입을 시험해 봤습니다. 
			이 제품은 여러분, 커피 애호가들을 가장 선호하는 소셜 네트워크와 곧바로 연결하고 있습니다. 
			이를 위해 저희는 대규모 투자를 했으며, 
			RFID, NFC, 블루투스, 와이파이가 탑재된(기술전문가들만이 알고 있는 몇 가지 기능도 포함되어 있죠. 
			자세한 내용은 저도 잘 모릅니다. 전 그저 커피를 좋아하는 한 사람일 뿐이에요) 재사용가능한 커피 컵을 만들었습니다. 
		</p>
		<p>
			자, 이 놀라운 신제품 컵에 주목하세요. 
			시골커피 관계자가  직접 들려주는,  
			이 새로운 발명품에 관한 모든 소식을 알려주기 위한 비디오 광고도 곧 선보일 예정입니다. 
		</p>
		</article>
		<article>
		<header>
			<h1>시골커피는 컴퓨터 과학을 이용합니다</h1>
			<time datetime="2023-03-10">3/10/2023</time>
		</header>
		<p>
			저희 시골커피가 얼마나 효율적인지 알고 있나요?
			고객들이 주문하는 천문학적인 숫자의 다양한 음료에도 불구하고, 
			제작현장에서는 언제나 빠른 배송을 하고 있습니다. 
			이 덕분에 여러분이 원하는 따끈따끈한 (원한다면 차가운) 음료를
			순식간에 여러분 눈앞에 갖다 드리고 있습니다. 
			과연 어떻게 하는 것일까요?
		</p>
		<p>
			이를 가능하게 하려고, 저희는 최신 컴퓨터과학 기술을 이용하고 있습니다. 
			실제로, 대형 분산컴퓨터로 직원들을 교육하고 있습니다. 
			계산대 직원들은 특별한 지침에 의해 여러분의 이름과 
			주문한 음료와 함께 이 분산컴퓨터에 주문을 입력합니다. 
			그리고 나서 음료를 만드는 전문직원이 컵을 가져와 입력된 주문에 따라 음료를 만듭니다.  
		</p>
		<p>
			이런 설계 덕분에, 저희는 원하는 시간에 작업량을 분산해 처리할 수 있습니다. 
			저희에게 필요한 것이라고는 고객의 주문 증가함에 따른  
			판매대 직원과 음료제작 직원의 추가 채용 뿐입니다. (물론 여러분이 모르는 수많은 직원들의 지원도 포함해서)
		</p>
		</article>
		<article>
		<header>
			<h1>이 달의 최우수 고객</h1>
			<time datetime="2023-02-18">2/18/2023</time>
		</header>
		<p>
			이 달의 최우수 고객상은 부산광역시 동래구에 있는 고객에게 돌아갔습니다.
			이분은 매일 아침 "6스푼의 감미료를 넣고, 우유를 넣기 전 감미료를 저은, 거품 없는 130도 지방이 없는 소이라테"를 주문했습니다. 
			최우수 고객을 어떻게 뽑는지 알고 싶나요? 
		</p>
		</article>
	    </section>
	    <!-- sidebar -->
	    <aside>
	    	<p class="beanheading">
	       	<img src="/images/bag.gif" alt="Bean Machine bag">
	       	<br>
	       	온라인으로 주문하세요  
	       	<a href="../form.jsp">커피공장</a>
	       	<br>
	       	<span class="slogan">
	        빠르고 <br>
	        신선하게 <br>
	        여러분의 집으로 직접 배송해 드립니다 <br>
	       	</span>
	     	</p>
	     	<p>
	       		무엇을 망설이고 있나요? 저희가 마련한 최신 자동주문 시스템인 커피공장을 통해
	     		온라인으로 지금 바로 품질좋은 커피를 주문할 수 있습니다. 어떻게 주문하냐고요?
	     		커피공장 링크를 클릭해서 주문서를 작성하면, 무대 뒤에서 커피를 준비하고, 
	     		포장해서 여러분 집 앞으로 바로 배달해 드립니다. 
	     	</p>
		</aside>
	</div>
</div>
<div id="coupon">
	<a href="../freecoffee.jsp" title="공짜 커피를 먹고 싶다면 여기를 클릭하세요">
		<img src="/images/ticket.gif" alt="시골커피 쿠폰티켓">
	</a>
</div>

<%@ include file="/admin/include/footer.jsp"%>