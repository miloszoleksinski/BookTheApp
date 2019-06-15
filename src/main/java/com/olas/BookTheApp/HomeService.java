package com.olas.BookTheApp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HomeService 
{
	@Autowired
	private HomeRepository homeRepository;
	
	public void bookAnHour(String time, String person, String title, int timeOfAppointment, int priceOfAppointment)
	{
		homeRepository.bookAnHour(time, person, title, timeOfAppointment, priceOfAppointment);
	}
	
	public List<AppointmentModel> getAppointments()
	{
		return homeRepository.getAppointments();
	}
	
	public List<HourModel> getHours(int appTime)
	{
		int numOfAppointments = 0;
		numOfAppointments = appTime/20;
		return homeRepository.getHours(numOfAppointments);
	}
	
	public List<HourModel> getHoursByDay(int dayNum, String monthAndYear, int appTime)
	{
		int numOfAppointments = 0;
		numOfAppointments = appTime/20;
		return homeRepository.getHoursByDay(dayNum, monthAndYear, numOfAppointments);
	}
	
	public int getToday()
	{
		return homeRepository.getToday();
	}
	
	public int getWeekDay()
	{
		return homeRepository.getWeekDay();
	}
	
	public int[] getDayOfTheWeek(int today)
	{
		return homeRepository.getDayOfTheWeek(today);
	}
	
	public String getYearAndMonth()
	{
		return homeRepository.getYearAndMonth();
	}
	
	public String getYearAndMonthInNumbers()
	{
		return homeRepository.getYearAndMonthInNumbers();
	}
	
	public int getTodayIndex(int today, int[] list)
	{
		for(int i=0; i<list.length; i++)
		{
			if( today == list[i] ) { return i; }
		}
		return 0;
	}
	
	public void deleteExpiredHours()
	{
		homeRepository.deleteExpiredHours();
	}
	
	public void addNewHours()
	{
		homeRepository.addNewHours();
	}
}
