package com.olas.BookTheApp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class HomeRepository 
{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void bookAnHour(String time, String person, String title, int timeOfAppointment, int priceOfAppointment)
	{
		String bookHour = "UPDATE hour SET reserved=1 WHERE hours='"+time+"'";
		jdbcTemplate.update( bookHour);
		
		String addReservation = "INSERT INTO reservation VALUE (null,'"+time+"','"+person+"','"+title+"',"+timeOfAppointment+","+priceOfAppointment+")";
		jdbcTemplate.update( addReservation);
		
		int numOfAppointments = timeOfAppointment/20;
		for(int i=0; i<numOfAppointments; i++)
		{
			String bookHours = "UPDATE hour SET reserved=1 WHERE hours='"+time+"' + INTERVAL "+(i*20)+ " MINUTE";
			jdbcTemplate.update( bookHours);
		}
	}
	
	public List<AppointmentModel> getAppointments()
	{
		String selectAppointments = "SELECT * FROM appointment";
		List<AppointmentModel> appointments = jdbcTemplate.query(selectAppointments, new AppointmentsRowMapper());
		return appointments;
	}
	
	public List<HourModel> getHours(int numOfAppointments)
	{
		String selectHours = "SELECT DATE(hours) AS date, TIME(hours) AS hours, reserved FROM hour"
				+ " WHERE hours > NOW() AND hours < CURDATE() + INTERVAL 1 DAY";
		List<HourModel> allAvaiableHours = jdbcTemplate.query(selectHours, new HoursRowMapper());
		
		List<HourModel> hours = getOnlyValidHours(allAvaiableHours, numOfAppointments);
		
		return hours;
	}
	
	public List<HourModel> getHoursByDay(int dayNum, String monthAndYear, int numOfAppointments)
	{
		int today = getToday();
		if( dayNum < today )
		{
			int month = Integer.parseInt(monthAndYear.substring(5));
			if( month == 12 ) { month = 1; }
			else { month++; } 
			monthAndYear = monthAndYear.substring(0,5) + month;
		}
		String date = monthAndYear + "-" + dayNum + " 00:00:00";
		int dayDifference = countDaysDifference(date);
		String selectHours = "SELECT DATE(hours) AS date, TIME(hours) AS hours, reserved FROM hour"
				+ " WHERE hours > CURDATE() + INTERVAL " + dayDifference + " DAY AND hours < CURDATE() + INTERVAL " + (dayDifference+1) + " DAY";
		List<HourModel> allAvaiableHoursByDay = jdbcTemplate.query(selectHours, new HoursRowMapper());
		
		List<HourModel> hours = getOnlyValidHours(allAvaiableHoursByDay, numOfAppointments);
		
		return hours;
	}
	
	public void deleteExpiredHours()
	{
		String deleteHours = "DELETE FROM hour WHERE hours < NOW()";
		jdbcTemplate.update( deleteHours );
	}
	
	public void addNewHours()
	{
		int daysDifference = countDaysDifference(getLatestHours());
		if( daysDifference < 7 )
		{
			if( daysDifference == -1 )
			{
				for(int i=0; i<8; i++)
				{
					String addHours = "INSERT INTO hour VALUES" + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 17 HOUR,0)";
					jdbcTemplate.update(addHours);
				}
			}
			else
			{
				for(int i=daysDifference+1; i<8; i++)
				{
					String addHours = "INSERT INTO hour VALUES" + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 10 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 11 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 12 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 13 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 14 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 15 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR + INTERVAL 20 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 16 HOUR + INTERVAL 40 MINUTE,0)," + 
							"(null,CURDATE() + INTERVAL " + i + " DAY + INTERVAL 17 HOUR,0)";
					jdbcTemplate.update(addHours);
				}
			}
		}
	}
	
	public boolean checkIfHourIsValid(int numOfAppointments, List<Integer> numbers)
	{
		int numbersLength = numbers.size();
		if( numbersLength < numOfAppointments ) { return false; }
			
		for(int i=0; i<numbersLength; i++)
		{
			if( numbers.get(i) == 1 ) { return false; } 
		}
		return true;
	}
	
	public List<HourModel> getOnlyValidHours(List<HourModel> allAvaiableHours, int numOfAppointments)
	{
		List<HourModel> hours = new ArrayList<HourModel>();
		for(int i=0; i<allAvaiableHours.size(); i++)
		{
			List<Integer> numbers = new ArrayList<Integer>();
			for(int j=0; j<numOfAppointments; j++)
			{
				try 
				{
					numbers.add( allAvaiableHours.get(i+j).getReserved() );
				}
				catch(IndexOutOfBoundsException e) { break; }
			}
			if( checkIfHourIsValid(numOfAppointments, numbers) == true ) { hours.add( allAvaiableHours.get(i) ); }
		}
		return hours;
	}
	
	public int countDaysDifference(String date)
	{
		String selectDaysDifference = "SELECT DATEDIFF('"+date+"', NOW())";
		Integer daysDifference = jdbcTemplate.queryForObject(selectDaysDifference, Integer.class);
		if( daysDifference == null ){ daysDifference = -1; }
		return daysDifference;
	}
	
	public String getLatestHours()
	{
		String selectHours = "SELECT MAX(hours) AS latest FROM hour";
		return jdbcTemplate.queryForObject(selectHours, String.class);
	}
	
	public int getToday()
	{
		String selectDay = "SELECT DAY( CURDATE() )";
		int today = jdbcTemplate.queryForObject(selectDay, Integer.class);
		return today;
	}
	
	public int getWeekDay()
	{
		String selectDay = "SELECT WEEKDAY( CURDATE() )";
		int today = jdbcTemplate.queryForObject(selectDay, Integer.class);
		return today;
	}
	
	public int[] getDayOfTheWeek(int today)
	{
		int[] days = new int[20];
		
		int counter = 0;
		for(int i=today; i>=1; i--)
		{
			String selectDayBefore = "SELECT DAY( CURDATE() - INTERVAL " + i + " DAY )";
			days[counter] = jdbcTemplate.queryForObject(selectDayBefore, Integer.class);
			counter++;
		}
		days[today] = jdbcTemplate.queryForObject("SELECT DAY( CURDATE() )", Integer.class);
		
		counter = today;
		for(int i=1; i<14; i++)
		{
			counter++;
			String selectDayAfter = "SELECT DAY( CURDATE() + INTERVAL " + i + " DAY )";
			days[counter] = jdbcTemplate.queryForObject(selectDayAfter, Integer.class);
		}
		
		return days;
	}
	
	public String getYearAndMonthInNumbers()
	{
		String selectYear = "SELECT YEAR( NOW() )";
		String selectMonth = "SELECT MONTH( NOW() )";
		int year = jdbcTemplate.queryForObject(selectYear, Integer.class);
		int monthNum = jdbcTemplate.queryForObject(selectMonth, Integer.class);
		
		return year + "-" + monthNum;
	}
	
	public String getYearAndMonth()
	{
		String selectYear = "SELECT YEAR( NOW() )";
		String selectMonth = "SELECT MONTH( NOW() )";
		int year = jdbcTemplate.queryForObject(selectYear, Integer.class);
		int monthNum = jdbcTemplate.queryForObject(selectMonth, Integer.class);
		String month = "";
		if(monthNum==1){month="Styczeñ";}else if(monthNum==2) {month="Luty";}
		else if(monthNum==3) {month="Marzec";}else if(monthNum==4) {month="Kwiecieñ";}
		else if(monthNum==5) {month="Maj";}else if(monthNum==6) {month="Czerwiec";}
		else if(monthNum==7) {month="Lipiec";}else if(monthNum==8) {month="Sierpieñ";}
		else if(monthNum==9) {month="Wrzesieñ";}else if(monthNum==10) {month="PaŸdziernik";}
		else if(monthNum==11) {month="Listopad";}else if(monthNum==12) {month="Grudzieñ";}
		
		return month + " " + year;
	}
	
	
	// ------------------------------------------- ROW MAPPERS ------------------------------------------- //
	private class AppointmentsRowMapper implements RowMapper<AppointmentModel>
	{ 
		public AppointmentModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			AppointmentModel appointment = new AppointmentModel();
			appointment.setTitle( rs.getString("title") );
			appointment.setDescription( rs.getString("description") );
			appointment.setPrice( Integer.parseInt(rs.getString("price")) );
			appointment.setTime( Integer.parseInt(rs.getString("time")) );
			return appointment; 
		} 
	}
	
	private class HoursRowMapper implements RowMapper<HourModel>
	{ 
		public HourModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			HourModel hour = new HourModel();
			hour.setReserved( Integer.parseInt(rs.getString("reserved")) );
			hour.setTime( rs.getString("hours").substring(0, 5) );
			hour.setDate( rs.getString("date") );
			return hour; 
		} 
	}
}
