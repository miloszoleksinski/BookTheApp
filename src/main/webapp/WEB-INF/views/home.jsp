<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<title>Home</title>
	<style>
		*{ margin: 0; padding: 0; box-sizing: border-box; }
		body{ width: 100%; background-color: black; position: relative; }
		
		.navbar{ position: fixed; height: 40px; width: 100%; background-color: black; display: flex; line-height: 40px; color: white; padding: 0 8%; z-index: 10; }
		.navbarHeight{ height: 40px; }
		.navbarTitle{ font-weight: bold; font-size: 1.2em; }
		.navbarTitle:hover{ cursor: pointer; color: rgb(232,232,232); }
		.navbarPhone{ text-decoration: none; font-weight: bold; color: white; text-align: right; }
		.navbarPhone:hover{ color: rgb(232,232,232); }
		
		/* FULL CONTAINER */
		.fullContainer{ background-color: white; padding: 30px 5%; }
			.topPanel{ width: 100%; display: flex; margin-bottom: 30px; }
			.leftPanel{ display: flex; flex-direction: column; width: 65%; margin: 18px 10px 0 0; }
				/* PICTURES DIV */
				.pictureDiv{ width: 100%; height: 501px; margin-bottom: 20px; }
				.Slider{ width: 100%; height: 401px; position: relative; display: flex; overflow: hidden; }
				.imageHolder{ transition: all 0.5s ease; width: 300%; height: 401px; display: flex; justify-content: space-around; }
				.imageHolderWithoutTransition{ width: 300%; height: 401px; display: flex; justify-content: space-around; }
				.firstImage{ margin-left: 0; }
				.secondImage{ margin-left: -200%; }
				.thirdImage{ margin-left: -300%; }
				.fourthImage{ margin-left: -400%; }
				.picture{ height: 399px; max-width: 100%; position: absolute; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
				.disabled{ display: none; }
				.leftPictureButton{ background-color: rgba(266,266,266,0.5); text-align: center; position: absolute; left: 0;  height: 400px; width: 100px; z-index: 8; }
				.leftPictureButton:hover{ background-color: rgba(180,180,180,0.5); cursor: pointer; }
				.leftPictureButton:hover .iconPictureButton{ color: white; }
				.rightPictureButton{ background-color: rgba(266,266,266,0.5); text-align: center; position: absolute; right: 0;  height: 400px; width: 100px; z-index: 8; }
				.rightPictureButton:hover{ background-color: rgba(180,180,180,0.5); cursor: pointer; }
				.rightPictureButton:hover .iconPictureButton{ color: white; }
				.iconPictureButton{ color: rgba(100,100,100,0.5); font-size: 4em; margin: auto; line-height: 400px; vertical-align: middle; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
				
				.disabledButton{ pointer-events: none; }
				
				.smallPicturesDiv{ background-color: rgba(10,10,10,0.5); height: 100px; display: flex; justify-content: center; }
				.smallPictureDiv{ height: 80px; width: 80px; cursor: pointer; background-color: white; margin: auto 5px; text-align: center; border-radius: 5px; overflow: hidden; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
				.activeSmallPictureDiv{ border: 2px solid #ff751a; transition: all 0.2s ease; }
				.smallPicture{ max-height: 80px; max-width: 80px; }
				/* END OF PICTURES DIV */
				/* APPOINTMENT DIV */
				.bookAppointmentDiv{ text-align: center; width: 100%; }
				.bookAppointments{ width: 100%; border-radius: 5px; border: 3px solid rgb(232, 232, 232); }
				.appointment{ padding: 10px; text-align: left; border-bottom: 1px solid rgb(232, 232, 232); display: flex; }
				
				.appointmentText{ display: flex; flex-direction: column; flex: 3; margin-right: 5px; }
				.appointmentTitle{ display: inline-block; font-size: 1.2em; font-weight: bold; padding-bottom: 2px; margin-bottom: 10px; border-bottom: 2px solid black; }
				.appointmentDescription{ color: #8b908f; font-size: 0.8em; }
				
				.appointmentInfo{ flex: 2; display: flex; flex-wrap: wrap; margin: auto 0 auto 5px; text-align: center; justify-content: flex-end; }
				.appointmentElement{ margin: 0 3px; padding: 5px; }
				.appointmentPrice{ font-weight: bold; }
				.appointmentTime{ color: #8b908f; }
				.appointmentButton{ background-color: #ff751a; border-radius: 5px; border: 1px solid #e65c00; color: white; font-weight: bold; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
				.appointmentButton:hover{ cursor: pointer; background-color: #e65c00; border: 1px solid #cc5200; }
				.appointmentButton:active{ background-color: #cc5200; }
				/* ENF OF APPOINTMENT DIV */
			
			.rightPanel{ width: 35%; margin: 18px 0 0 10px; height: 490px; z-index: 9; position: relative; }
				.rightPanelFlexDiv{ width: 100%; height: 490px; display: flex; flex-direction: column; }
				.rightPanelFlexDivFly{ position: fixed; width: 31%; top: 40px; height: 490px; }
				/* GOOGLE MAP DIV */
				.googleMapDiv{ margin-bottom: 2%; height: 400px; flex: 2; border: 0; width: 100%; background-color: rgb(240, 240, 240); border-radius: 5px; padding-top: 5px; }
				.googleMap{ border: 0; width: 100%; height: 250px; }
				.addresDiv{ padding: 10px 15px; }
				.addresTitle{ height: 40px; line-height: 40px; font-weight: bold; font-size: 0.9em; vertical-align: middle; }
				.addresInfo{ padding: 6px; }
				.telephoneNumber{ padding: 6px; text-decoration: none; color: #ff751a; font-weight: bold;  }
				.telephoneNumber:hover{ color: #cc5200; }
				/* END OF GOOGLE MAP DIV */
				/* OPEN TIME DIV */
				.openTimeDiv{ background-color: rgb(240, 240, 240); height: 100%; width: 100%; border-radius: 5px; padding: 10px 15px; flex: 1; }
				.openTimeTitle{ height: 40px; line-height: 40px; font-weight: bold; vertical-align: middle; }
				.iconWithText{ color: #ff751a; font-size: 1.5em; margin: 0 5px 3px 0; vertical-align: middle; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
				.phoneIcon{ margin: 0 5px 7px 0; }.timeIcon{ margin: 0 5px 5px 0; }
				.openFlex{ display: flex; padding: 6px; }
				.openDays{ flex: 1; } 
				.openTime{ flex: 1; font-weight: bold; display: flex; justify-content: flex-end; } 
				/* END OF OPEN TIME DIV */
		/* END OF FULL CONTAINER */
		
		.gallery{ text-align: center; padding-bottom: 30px; }
		.galleryTitle{ display: inline-block; padding-bottom: 2px; font-size: 1.2em; font-weight: bold; border-bottom: 2px solid black; }
		.galleryFlexDiv{ display: flex; justify-content: center; flex-wrap: wrap; width: 100%; margin: 20px 0; }
		.galleryPictureDiv{ flex-basis: 31%; margin: 1%; }
		.galleryPicture{ width: 100%; }
		.galleryPicture:hover{ cursor: pointer; }
		
		#imagesOverlay{ height: 100%; position: absolute; top: 0; right: 0; bottom: 0; left: 0; background-color: rgba(0,0,0,0.5); z-index: 20; }
		.enabled{ display: block; }
		.disabled{ display: none; }
		.contentOfTheImagesOverlay{ position: fixed; height: 100%; width: 100%; background-color: rgba(0,0,0,0); }
		#imageContainerID{ height: 100%; position: relative; }
		.overlayImage{ max-height: 80%; max-width: 90%; position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin: auto; }
		
		#reservationOverlay{ height: 100%; position: absolute; top: 0; right: 0; bottom: 0; left: 0; background-color: rgba(0,0,0,0.5); z-index: 20; }
		.contentOfTheReservationOverlay{ position: fixed; width: 60%; background-color: white; top: 10%; left: 20%; max-height: 80%; overflow: auto; padding-top: 50px; }
		.reservationContentNavbar{ position: fixed; top: 10%; left: 20%; width: 60%; background-color: white; height: 50px; line-height: 50px; text-align: center; border-bottom: 1px solid rgb(230, 230, 230); color: rgb(100, 100, 100); font-weight: lighter; z-index: 21; }
		.closeButton{ position: absolute; top: 12px; right: 30px; line-height: 25px; font-size: 1.8em; font-weight: bold; color: rgb(230, 230, 230); -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
		.closeButton:hover{ cursor: pointer; color: rgb(150, 150, 150); }
		.leftArrowButton{ position: absolute; top: 12px; left: 22px; line-height: 25px; font-size: 1.8em; font-weight: bold; color: rgb(230, 230, 230); -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
		.leftArrowButton:hover{ cursor: pointer; color: rgb(150, 150, 150); }
		.listOfHours{ width: 600px; margin: 10px auto; height: 250px; }
		.reservationHour{ display: inline-block; width: 90px; height: 50px; line-height: 50px; text-align: center; border: 1px solid rgb(200, 200, 200); margin: 5px; font-size: 1.05em; font-weight: bold; color: rgb(110, 110, 110); border-radius: 5px; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
		.reservationHour:hover{ color: #ff751a; border: 1px solid #e65c00; cursor: pointer; }
		.activeReservationHour{ color: #ff751a; border: 1px solid #e65c00; }
		.monthDiv{ height: 50px; width: 100%; border-bottom: 1px solid rgb(230, 230, 230); text-align: center; line-height: 50px; }
		.daysDiv{ height: 30px; width: 100%; border-bottom: 1px solid rgb(230, 230, 230); display: flex; }
		.day{ flex: 1; text-align: center; line-height: 30px; }
		.today{ background-color: crimson; color: white; }
		.today:hover{ cursor: pointer; }
		.closed{ opacity: 0.3; }
		.activeDay{ background-color: grey; }
		.numDay:hover{ background-color: grey; cursor: pointer; }
		.acceptBookingButton{ width: 100%; height: 40px; line-height: 40px; background-color: #ff751a; color: white; font-size: 1.2em; font-weight: bold; text-align: center; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
		.acceptBookingButton:hover{ cursor: pointer; background-color: #e65c00; text-align: center; }
		.acceptBookingButton:active{ background-color: #cc5200; }
		
		.passUsernameDiv{ border-top: 1px solid rgb(230, 230, 230); height: 80px; text-align: center;  }
		#fullName{ height: 30px; width: 250px padding: 0 8px; border-radius: 5px; border: 1px solid rgb(100, 100, 100); overflow: hidden; }
		.inputWithoutError{ margin-top: 25px; }
		.inputWithError{ margin-top: 15px; }
		.inputError{ color: crimson; height: 18px; line-height: 18px; }
		
		.reservationSucces{ position: absolute; width: 40%; height: 36%; left: 0; top: 0; bottom: 0; right: 0; margin: auto; background-color: white; border: 0.5px solid rgb(120, 120, 120); border-radius: 5px; -webkit-box-shadow: 0px 0px 5px 0px rgba(100,100,100,0.3); -moz-box-shadow: 0px 0px 5px 0px rgba(100,100,100,0.3); box-shadow: 0px 0px 5px 0px rgba(100,100,100,0.3); }
		.iconAndTextTitle{ display: flex; flex-wrap: wrap; }
		.iconSucces{ color: rgb(0, 204, 0); font-size: 6em; margin: auto 0; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
		.reservationSuccesTitle{ text-align: center; font-size: 2em; font-weight: bold; margin: auto; }
		.buttonReservationSucces{ width: 90px; padding: 5px; margin: auto; text-align: center; border: 3px solid #ff751a; color: #ff751a; font-size: 1.2em; font-weight: bold; border-radius: 8px; }
		.buttonReservationSucces:hover{ color: white; background-color: #ff751a; cursor: pointer; }
		#bookingInfo{ font-size: 1.1em; text-align: center; margin-bottom: 15px; }
		
		.footer{ height: 40px; width: 100%; line-height: 40px; background-color: black; text-align: center; color: white; }
		
		
		@media only screen and (max-width: 1200px) 
		{
			.leftPanel{ width: 100%; }
			.topPanel{ flex-direction: column; }
			.rightPanel{ width: 100%; margin-left: 0; padding-bottom: 15px; }
		}
		@media only screen and (max-width: 900px) 
		{
			.galleryPictureDiv{ flex-basis: 49%; margin: 0.5%; }
			.contentOfTheReservationOverlay{ left: 10%; width: 80%; }
			.reservationContentNavbar{ left: 10%; width: 80%; }
		}
		@media only screen and (max-width: 600px) 
		{
			.galleryPictureDiv{ flex-basis: 100%; margin: 1% 0; }
			.contentOfTheReservationOverlay{ left: 5%; width: 90%; }
			.reservationContentNavbar{ left: 5%; width: 90%; }
		}
	</style>
</head>
<body>
	<div id="imagesOverlay" class="disabled">
		<div id="contentOfTheImagesOverlayID" class="contentOfTheImagesOverlay">
			<div id="imageContainerID"></div>
		</div>
	</div>
	
	<div id="reservationOverlay" class="disabled">
		<div id="reservationNavbarID" class="reservationContentNavbar">WYBIERZ USŁUGĘ<div class="closeButton" onClick="toggleReservationOverlay()">&times;</div></div>
		<div id="contentOfTheReservationOverlayID" class="contentOfTheReservationOverlay">
			<c:forEach items="${appointments}" var="appointment" varStatus="i">
				<div class="appointment">
					<div class="appointmentText">
						<p>${appointment.title}</p>
						<p class="appointmentDescription">${appointment.description}</p>
					</div>
					<div class="appointmentInfo">
						<p class="appointmentElement appointmentPrice">${appointment.price}zł</p>
						<p class="appointmentElement appointmentTime">${appointment.time}min</p>
						<p class="appointmentElement appointmentButton" onClick="updateAppointmentDates('${appointment.time}','${appointment.price}','${appointment.title}');disableReservationEnableHours()">Rezerwuj</p>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div id="hoursNavbarID" class="reservationContentNavbar disabled"><div onClick="disableHoursEnableReservation()" class="material-icons leftArrowButton">keyboard_arrow_left</div>WYBIERZ DATĘ<div class="closeButton" onClick="toggleReservationOverlay();disableHoursEnableReservation()">&times;</div></div>
			<div id="contentOfTheHoursID" class="contentOfTheReservationOverlay disabled">
				<div id="monthDivID" class="monthDiv">${monthAndYear}</div>
				<div class="daysDiv">
					<div class="day">PON</div>
					<div class="day">WT</div>
					<div class="day">ŚR</div>
					<div class="day">CZW</div>
					<div class="day">PT</div>
					<div class="day">SB</div>
					<div class="day">NIE</div>
				</div>
				<div class="daysDiv">
					<c:forEach begin="0" end="6" items="${days}" var="day" varStatus="i">
						<c:choose>
							<c:when test="${day == today}">
								<div id="todayID" class="day today" onClick="changeReservationDay('todayID',${day})">${day}</div>
							</c:when>
							<c:when test="${i.index < todayIndex}">
								<div class="day closed">${day}</div>
							</c:when>
							<c:otherwise>
								<div id="dayNumber${i.index}" class="day numDay" onClick="changeReservationDay('dayNumber${i.index}',${day})">${day}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div class="daysDiv">
					<c:forEach begin="7" end="13" items="${days}" var="day" varStatus="i">
						<c:choose>
							<c:when test="${day == today}">
								<div id="todayID" class="day today" onClick="changeReservationDay('todayID',${day})">${day}</div>
							</c:when>
							<c:when test="${i.index > todayIndex + 7}">
								<div class="day closed">${day}</div>
							</c:when>
							<c:otherwise>
								<div id="dayNumber${i.index}" class="day numDay" onClick="changeReservationDay('dayNumber${i.index}',${day})">${day}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div id="listOfHoursID" class="listOfHours"></div>
				<div class="passUsernameDiv">
					<div id="notEnoughLetters" class="inputError disabled">Imię i nazwisko musi zawierać co najmniej 6 liter</div>
					<div id="NumbersAreForbidden" class="inputError disabled">Imię i nazwisko zawiera niedozwolone znaki</div>
					<div id="selectTheDate" class="inputError disabled">Wybierz godzinę do zarezerwowania</div>
					<input type="text" name="full name" placeholder="Imię i nazwisko" id="fullName" class="inputWithoutError">
				</div>
				<div onClick="makeReservationForAnHour()" class="acceptBookingButton">Potwierdź rezerwację</div>
				<div id="successID" class="reservationSucces disabled">
					<div class="iconAndTextTitle">
						<i class="material-icons iconSucces">check_circle_outline</i>
						<p class="reservationSuccesTitle">Termin zarezerwowany</p>
					</div>
					<div id="bookingInfo"></div>
					<div onClick="closeInformationWindow();toggleReservationOverlay()" class="buttonReservationSucces">Ok</div>
				</div>
		</div>
	</div>

	<div class="navbar">
		<p class="navbarTitle">Męskie Cięcie - Barber Shop</p>
		<p style="flex:1;"></p>
		<a class="navbarPhone" href="tel:+48794914894" title="Zadzwoń 794 914 894">Zadzwoń teraz</a>
	</div>
	<div class="navbarHeight"></div>
	
	<div class="fullContainer">
	
		<div class="topPanel">
			<div id="leftPanelID" class="leftPanel">
				<div class="pictureDiv">
					<div class="slider">
						<div id="leftPictureButtonID" class="leftPictureButton" onClick="leftButton()"><i class="material-icons iconPictureButton">keyboard_arrow_left</i></div>
						<div id="imageHolderID" class="imageHolder firstImage">
							<img class="picture" src='<c:url value="/resources/images/meskieciecie1.jpg"/>'>
							<img class="picture" style="margin-left:100%;" src='<c:url value="/resources/images/meskieciecie23.jpg"/>'>
							<img class="picture" style="margin-left:200%;" src='<c:url value="/resources/images/meskieciecie4.jpg"/>'>
							<img class="picture" style="margin-left:300%;" src='<c:url value="/resources/images/meskieciecie1.jpg"/>'>
						</div>
						<div id="rightPictureButtonID" class="rightPictureButton" onClick="rightButton()"><i class="material-icons iconPictureButton">keyboard_arrow_right</i></div>
					</div>
					<div class="smallPicturesDiv">
						<div id="smallPic1" onClick="changePicture(1)" class="smallPictureDiv activeSmallPictureDiv"><img class="smallPicture" src='<c:url value="/resources/images/meskieciecie1.jpg"/>'></div>
						<div id="smallPic2" onClick="changePicture(2)" class="smallPictureDiv"><img class="smallPicture" src='<c:url value="/resources/images/meskieciecie23.jpg"/>'></div>
						<div id="smallPic3" onClick="changePicture(3)" class="smallPictureDiv"><img class="smallPicture" src='<c:url value="/resources/images/meskieciecie4.jpg"/>'></div>
					</div>
				</div>
		
				<div class="bookAppointmentDiv">
					<p class="appointmentTitle">Zarezerwuj spotkanie</p>
					<div class="bookAppointments">
						<c:forEach items="${appointments}" var="appointment" varStatus="i">
							<div class="appointment">
								<div class="appointmentText">
									<p>${appointment.title}</p>
									<p class="appointmentDescription">${appointment.description}</p>
								</div>
								<div class="appointmentInfo">
									<p class="appointmentElement appointmentPrice">${appointment.price}zł</p>
									<p class="appointmentElement appointmentTime">${appointment.time}min</p>
									<p class="appointmentElement appointmentButton" onClick="updateAppointmentDates('${appointment.time}','${appointment.price}','${appointment.title}');toggleReservationOverlay();disableReservationEnableHours()">Rezerwuj</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			<div id="rightPanelID" class="rightPanel">
				<div id="rightPanelFlexID" class="rightPanelFlexDiv">
					<div class="googleMapDiv">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d411.7131444939705!2d19.91436159765714!3d53.06985086678343!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x471c548deed331d3%3A0xf5da3e3dcbcada5!2sM%C4%99skie+Ci%C4%99cie+-+Barber+Shop!5e0!3m2!1spl!2spl!4v1553954760989!5m2!1spl!2spl" class="googleMap"></iframe>
						<div class="addresDiv">
							<p class="addresTitle"><i class="material-icons iconWithText">place</i>Męskie Cięcie - Barber Shop</p>
							<p class="addresInfo">Tadeusza Kościuszki 15, 09-300 Żuromin</p>
							<a class="telephoneNumber" href="tel:+48794914894" title="Zadzwoń 794 914 894"><i class="material-icons iconWithText phoneIcon">phone</i>794 914 894</a>
						</div>
					</div>
					
					<div class="openTimeDiv">
						<p class="openTimeTitle"><i class="material-icons iconWithText timeIcon">schedule</i> Godziny otwarcia</p>
						<div class="openFlex">
							<p class="openDays">poniedziałek-sobota:</p>
							<p class="openTime">10:00-17:20</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="gallery">
			<p class="galleryTitle">Galeria</p>
			
			<div class="galleryFlexDiv">
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(1)" src='<c:url value="/resources/images/fryzura1.jpg"/>'></div>
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(2)" src='<c:url value="/resources/images/fryzura2.jpg"/>'></div>
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(3)" src='<c:url value="/resources/images/fryzura3.jpg"/>'></div>
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(4)" src='<c:url value="/resources/images/fryzura4.jpg"/>'></div>
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(5)" src='<c:url value="/resources/images/fryzura5.jpg"/>'></div>
				<div class="galleryPictureDiv"><img class="galleryPicture" onClick="toggleImagesOverlay();showPicture(6)" src='<c:url value="/resources/images/fryzura6.jpg"/>'></div>
			</div>
		</div>
		
	</div>
	
	<div class="footer">BookTheDate</div>
</body>
<script>
	//---------------------------------------- MAIN IMAGES ---------------------------------------- //
	var imageHolderID = document.getElementById("imageHolderID");
	var leftPictureButtonID = document.getElementById("leftPictureButtonID");
	var rightPictureButtonID = document.getElementById("rightPictureButtonID");
	
	var smallPic1 = document.getElementById("smallPic1");
	var smallPic2 = document.getElementById("smallPic2");
	var smallPic3 = document.getElementById("smallPic3");
		
	
	function rightButton()
	{
		rightPictureButtonID.className = "rightPictureButton disabledButton"
		setTimeout( function(){rightPictureButtonID.className = "rightPictureButton"}, 500 );
		
		if(imageHolderID.className == "imageHolder firstImage" || imageHolderID.className == "imageHolderWithoutTransition firstImage" )
		{
			imageHolderID.className = "imageHolder secondImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic3.className = "smallPictureDiv";
		}
		else if(imageHolderID.className == "imageHolder secondImage")
		{
			imageHolderID.className = "imageHolder thirdImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv activeSmallPictureDiv";
		}
		else if(imageHolderID.className == "imageHolder thirdImage")
		{
			imageHolderID.className = "imageHolder fourthImage";
			smallPic1.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv";
			setTimeout( function(){imageHolderID.className = "imageHolderWithoutTransition firstImage";}, 500 );
		}
	}
	
	function leftButton()
	{
		leftPictureButtonID.className = "leftPictureButton disabledButton";
		setTimeout( function(){leftPictureButtonID.className = "leftPictureButton";}, 500 );
		
		if(imageHolderID.className == "imageHolder firstImage" || imageHolderID.className == "imageHolderWithoutTransition firstImage" )
		{
			imageHolderID.className = "imageHolderWithoutTransition fourthImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv activeSmallPictureDiv";
			setTimeout( function(){imageHolderID.className = "imageHolder thirdImage";}, 3 );
		}
		else if(imageHolderID.className == "imageHolder secondImage" )
		{
			imageHolderID.className = "imageHolder firstImage";
			smallPic1.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv";
		}
		else if(imageHolderID.className == "imageHolder thirdImage")
		{
			imageHolderID.className = "imageHolder secondImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic3.className = "smallPictureDiv";
		}
	}
	
	function changePicture(id)
	{
		if( id == 1 )
		{
			imageHolderID.className = "imageHolder firstImage";
			smallPic1.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv";
		}
		else if( id == 2 )
		{
			imageHolderID.className = "imageHolder secondImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv activeSmallPictureDiv";
			smallPic3.className = "smallPictureDiv";
		}
		else if( id == 3 )
		{
			imageHolderID.className = "imageHolder thirdImage";
			smallPic1.className = "smallPictureDiv";
			smallPic2.className = "smallPictureDiv";
			smallPic3.className = "smallPictureDiv activeSmallPictureDiv";
		}
	}
	//---------------------------------------- MAIN IMAGES ---------------------------------------- //
	
	//---------------------------------------- SHOW BIG PICTURE ---------------------------------------- //
	function showPicture(pictureNum)
	{
		var overlayImage = "<img class='overlayImage' src='<c:url value='/resources/images/fryzura"+pictureNum+".jpg'/>'>";
		$('#imageContainerID').html( overlayImage );
	}
	
	function toggleImagesOverlay()
	{
		var body = document.getElementsByTagName("BODY")[0];
		var imagesOverlay = document.getElementById("imagesOverlay");
		
		if( imagesOverlay.className == "disabled" ) { imagesOverlay.className = "enabled"; body.style.overflow = "hidden"; }
		else{ imagesOverlay.className = "disabled"; body.style.overflow = "auto"; }
	}
	
	$( "#imageContainerID" ).on('click', function(e) {
		if (e.target === this)
		{
			toggleImagesOverlay();
		}
	});
	
	$( "#contentOfTheImagesOverlayID" ).on('click', function(e) {
		if (e.target === this)
		{
			toggleImagesOverlay();
		}
	});
	//---------------------------------------- SHOW BIG PICTURE ---------------------------------------- //
	
	// ---------------------------------------- RIGHT PANEL FLYING ---------------------------------------- //
	var rightPanelFlexID = document.getElementById("rightPanelFlexID");
	var mediaQueryMax1200 = window.matchMedia("(max-width: 1200px)");
	var mediaQueryMax900 = window.matchMedia("(max-width: 900px)");
	var mediaQueryMax600 = window.matchMedia("(max-width: 600px)");
	
	function flyingPanelChangeClass()
	{
		var leftPanelHeight= document.getElementById("leftPanelID").offsetHeight;
		var rightPanelHeight = document.getElementById("rightPanelID").offsetHeight;
		var endOfFlyingHeight = leftPanelHeight - rightPanelHeight + 35;
		
		var bodyTag = document.body;
		if( bodyTag.scrollTop > endOfFlyingHeight )
		{
			rightPanelFlexID.className = "rightPanelFlexDiv";
			rightPanelFlexID.style.marginTop = (endOfFlyingHeight-48) + "px";
			rightPanelFlexID.style.top = "0px";
		}
		else if( bodyTag.scrollTop > 48 )
		{
			rightPanelFlexID.className = "rightPanelFlexDiv rightPanelFlexDivFly";
			rightPanelFlexID.style.marginTop = "0px";
			rightPanelFlexID.style.top = "40px";
		}
		else
		{
			rightPanelFlexID.className = "rightPanelFlexDiv";
			rightPanelFlexID.style.marginTop = "0px";
			rightPanelFlexID.style.top = "0px";
		}
	}
	
	window.onscroll = function(){
		if( mediaQueryMax1200.matches || mediaQueryMax900.matches || mediaQueryMax600.matches )
		{ rightPanelFlexID.style.marginTop = "0px"; }
		else{ flyingPanelChangeClass(); }
	};
	
	function watchMedia()
	{
		if( mediaQueryMax1200.matches || mediaQueryMax900.matches || mediaQueryMax600.matches )
		{ rightPanelFlexID.className = "rightPanelFlexDiv"; rightPanelFlexID.style.marginTop = "0px"; }
		else{ flyingPanelChangeClass(); }
	}
	
	watchMedia();
	mediaQueryMax1200.addListener(watchMedia);
	mediaQueryMax900.addListener(watchMedia);
	mediaQueryMax600.addListener(watchMedia);
	// ---------------------------------------- RIGHT PANEL FLYING ---------------------------------------- //
	
	// ---------------------------------------- RESERVATION OVERLAY ---------------------------------------- //
	function toggleReservationOverlay()
	{
		var body = document.getElementsByTagName("BODY")[0];
		var reservationOverlay = document.getElementById("reservationOverlay");
		
		if( reservationOverlay.className == "disabled" ) { reservationOverlay.className = "enabled"; body.style.overflow = "hidden"; }
		else{ reservationOverlay.className = "disabled"; body.style.overflow = "auto"; }
		closeInformationWindow();
		clearDataInfo();
	}
	
	function disableReservationEnableHours()
	{
		var contentOfTheReservationOverlayID = document.getElementById("contentOfTheReservationOverlayID");
		var reservationNavbarID = document.getElementById("reservationNavbarID");
		var contentOfTheHoursID = document.getElementById("contentOfTheHoursID");
		var hoursNavbarID = document.getElementById("hoursNavbarID");
		
		contentOfTheReservationOverlayID.className = "contentOfTheReservationOverlay disabled";
		reservationNavbarID.className = "reservationContentNavbar disabled";
		contentOfTheHoursID.className = "contentOfTheReservationOverlay";
		hoursNavbarID.className = "reservationContentNavbar";
	}
	
	function disableHoursEnableReservation()
	{
		var contentOfTheReservationOverlayID = document.getElementById("contentOfTheReservationOverlayID");
		var reservationNavbarID = document.getElementById("reservationNavbarID");
		var contentOfTheHoursID = document.getElementById("contentOfTheHoursID");
		var hoursNavbarID = document.getElementById("hoursNavbarID");
		
		contentOfTheReservationOverlayID.className = "contentOfTheReservationOverlay";
		reservationNavbarID.className = "reservationContentNavbar";
		contentOfTheHoursID.className = "contentOfTheReservationOverlay disabled";
		hoursNavbarID.className = "reservationContentNavbar disabled";
		closeInformationWindow();
		clearDataInfo();
	}
	
	function toggleReservationHours()
	{
		if( contentOfTheReservationOverlayID.className == "contentOfTheReservationOverlay" )
		{
			disableReservationEnableHours();
		}
		else
		{
			disableHoursEnableReservation();
		}
	}
	
	$( "#reservationOverlay" ).on('click', function(e) {
		if (e.target === this)
		{
			toggleReservationOverlay();
			disableReservationEnableHours();
			closeInformationWindow();
	    	clearDataInfo();
		}
	});
	
	function closeInformationWindow()
	{
		var successID = document.getElementById( "successID" );
    	successID.className = "reservationSucces disabled";
	}
	// ---------------------------------------- RESERVATION OVERLAY ---------------------------------------- //
	// ---------------------------------------- JQUERY AJAX ---------------------------------------- //
	var appTime = 0;
	var appPrice = 0;
	var appTitle = "";
	var appReservationDate = "";
	var appReservationHour = "";
	
	function clearDataInfo()
	{
		var elements = document.getElementsByClassName("activeDay day numDay");
		for(var i=0; i<elements.length; i++)
		{
			elements[i].className = "day numDay";
		}
		
		appReservationDate = "";
		appReservationHour = "";
		
		var notEnoughLetters = document.getElementById( "notEnoughLetters" );
		var NumbersAreForbidden = document.getElementById( "NumbersAreForbidden" );
		var selectTheDate = document.getElementById( "selectTheDate" );
		
		notEnoughLetters.className = "inputError disabled";
		NumbersAreForbidden.className = "inputError disabled";
		selectTheDate.className = "inputError disabled";
	}
	
	function updateAppointmentDates(appointmentTime, appointmentPrice, appointmentTitle) 
	{
		appTime = appointmentTime;
		appPrice = appointmentPrice;
		appTitle = appointmentTitle;
		
		var dataObj = {appTime : appTime};
	    $.ajax({
	        url : '/BookTheApp/updateAppointmentDates',
	        data : dataObj,
	        success: function(data)
	        {
	        	var hours = [];
	        	var appointmentDateHTML = "";
	        	for(var i=0; i<data.length; i++)
	        	{
	        		hours.push( JSON.parse( data[i] ) );
	        		appointmentDateHTML += "<div id='hourNum"+i+"' onClick='chooseReservationHour(\""+hours[i].date+"\",\""+hours[i].time+"\",\"hourNum"+i+"\")' class='reservationHour'>"+hours[i].time+"</div>";
	        	}
	        	$('#listOfHoursID').html( appointmentDateHTML );
	        }
	    });
	}
	
	function changeReservationDay(dayID, dayNum)
	{
		var elements = document.getElementsByClassName("activeDay day numDay");
		for(var i=0; i<elements.length; i++)
		{
			elements[i].className = "day numDay";
		}
		
		var myDay = document.getElementById( dayID );
		if( myDay.className == "day numDay" || myDay.className == "activeDay day numDay" )
		{
			myDay.className = "activeDay day numDay";
		}
		
		var dataObj = {dayNum : dayNum, appTime : appTime};
		$.ajax({
	        url : '/BookTheApp/changeDayOfAppointments',
	     	data : dataObj,
	     	cache : false,
	        success: function(data)
	        {
	        	var hours = [];
	        	var appointmentDateHTML = "";
	        	for(var i=0; i<data.length; i++)
	        	{
	        		hours.push( JSON.parse( data[i] ) );
	        		appointmentDateHTML += "<div id='hourNum"+i+"' onClick='chooseReservationHour(\""+hours[i].date+"\",\""+hours[i].time+"\",\"hourNum"+i+"\")' class='reservationHour'>"+hours[i].time+"</div>";
	        	}
	        	$('#listOfHoursID').html( appointmentDateHTML );
	        }
	    });
	}
	
	function chooseReservationHour(hourDate, hourTime, hourID)
	{
		appReservationDate = hourDate + " ";
		appReservationHour = hourTime;
		
		var elements = document.getElementsByClassName("reservationHour activeReservationHour");
		for(var i=0; i<elements.length; i++)
		{
			elements[i].className = "reservationHour";
		}
		
		var myHour = document.getElementById( hourID );
		myHour.className = "reservationHour activeReservationHour";
	}
	
	function makeReservationForAnHour()
	{
		var notEnoughLetters = document.getElementById( "notEnoughLetters" );
		var NumbersAreForbidden = document.getElementById( "NumbersAreForbidden" );
		var selectTheDate = document.getElementById( "selectTheDate" );
		notEnoughLetters.className = "inputError disabled";
		NumbersAreForbidden.className = "inputError disabled";
		selectTheDate.className = "inputError disabled";
		
		var fullName = document.getElementById('fullName');
		var fullNameValue = fullName.value;
		fullName.className = "inputWithoutError";
		
		if( appReservationDate == "" || !!appReservationHour == "" )
		{
			selectTheDate.className = "inputError";
			fullName.className = "inputWithError";
		}
		else if( fullNameValue.length <= 5 )
		{
			notEnoughLetters.className = "inputError";
			fullName.className = "inputWithError";
		}
		else if( ! /^[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ ]+$/.test(fullNameValue) )
		{
			NumbersAreForbidden.className = "inputError";
			fullName.className = "inputWithError";
		}
		else
		{
			var dataObj = {hourDate : appReservationDate, hourTime : appReservationHour, appTime : appTime, appPrice : appPrice, appTitle : appTitle, fullName : fullNameValue};
			$.ajax({
		        url : '/BookTheApp/makeReservationForAnHour',
		        data : dataObj,
		     	cache : false,
		        success: function(data)
		        {
		        	var successID = document.getElementById( "successID" );
		        	successID.className = "reservationSucces";
		        	$('#bookingInfo').html( "Data: <b>" + appReservationDate + " " + appReservationHour + "</b><br> Cena: <b>" + appPrice + "zł</b>" );
		        }
		    });
		}
		
	}
	// ---------------------------------------- JQUERY AJAX ---------------------------------------- //
</script>
</html>
