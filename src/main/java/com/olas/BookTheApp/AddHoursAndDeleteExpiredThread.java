package com.olas.BookTheApp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class AddHoursAndDeleteExpiredThread implements Runnable
{
	@Autowired
	private HomeService homeService;
	
	@Override
	public void run() 
	{
		homeService.addNewHours();
		homeService.deleteExpiredHours();
	}
}
