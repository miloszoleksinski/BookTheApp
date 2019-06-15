package com.olas.BookTheApp;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController 
{
    @Autowired
    private ApplicationContext applicationContext;
	
	@Autowired
    private TaskExecutor taskExecutor;
	
	@Autowired
	private HomeService homeService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) 
	{
		AddHoursAndDeleteExpiredThread thread = applicationContext.getBean( AddHoursAndDeleteExpiredThread.class );
		taskExecutor.execute( thread );
		
		List<AppointmentModel> appointments = homeService.getAppointments();
		model.addAttribute("appointments", appointments);
		
		int today = homeService.getToday();
		model.addAttribute("today", today);
		
		int weekDay = homeService.getWeekDay();
		int[] days = homeService.getDayOfTheWeek(weekDay);
		model.addAttribute("days", days);
		
		model.addAttribute( "todayIndex", homeService.getTodayIndex(today, days) );
		
		model.addAttribute("monthAndYear", homeService.getYearAndMonth());
		
		return "home";
	}
}
