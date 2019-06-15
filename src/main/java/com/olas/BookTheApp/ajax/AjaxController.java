package com.olas.BookTheApp.ajax;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.olas.BookTheApp.HomeService;
import com.olas.BookTheApp.HourModel;

@Controller
public class AjaxController 
{
	@Autowired
	private HomeService homeService;
	
	@RequestMapping(value = "/updateAppointmentDates")
	public @ResponseBody List<String> addNewDatesAndDeleteExpired(int appTime)
	{
		homeService.deleteExpiredHours();
		
		List<HourModel> dates = homeService.getHours(appTime);
		ArrayList<String> jsonList = new ArrayList<String>();
		ObjectMapper mapper = new ObjectMapper();

		for(int i=0; i<dates.size(); i++)
		{
			try { jsonList.add( mapper.writeValueAsString( dates.get(i) ) );}
			catch (JsonProcessingException e) {return null;}
		}
		return jsonList;
	}
	
	@RequestMapping(value = "/changeDayOfAppointments")
	public @ResponseBody List<String> changeDayOfAppointments(int dayNum, int appTime)
	{
		homeService.deleteExpiredHours();
		
		List<HourModel> dates = homeService.getHoursByDay(dayNum, homeService.getYearAndMonthInNumbers(), appTime);
		ArrayList<String> jsonList = new ArrayList<String>();
		ObjectMapper mapper = new ObjectMapper();
		
		for(int i=0; i<dates.size(); i++)
		{
			try { jsonList.add( mapper.writeValueAsString( dates.get(i) ) );}
			catch (JsonProcessingException e) {return null;}
		}
		return jsonList;
	}
	
	@RequestMapping(value = "/makeReservationForAnHour")
	public @ResponseBody String makeReservationForAnHour(String hourDate, String hourTime, int appTime, int appPrice, String appTitle, String fullName)
	{
		homeService.deleteExpiredHours();
		
		String time = hourDate + " " + hourTime;
		homeService.bookAnHour(time, fullName, appTitle, appTime, appPrice);
		return "xxx";
	}
}
