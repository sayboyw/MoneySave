package hos.semi.service;

import java.util.Calendar;

import hos.semi.dto.MakeDTO;

public class MakeCal {

	// 달력 붙이기(전달)
		public MakeDTO makeMinus(String calYear, String calMonth) {
			Calendar cal = Calendar.getInstance(); // Calendar 클래스 사용 준비
			int month = Integer.parseInt(calMonth)-1;
			int year = Integer.parseInt(calYear);
	        
			if(month <= 0) {
	        	year = Integer.parseInt(calYear)-1;
	        	month = 12;
	        }else{
	        	System.out.println(month);
	        }
			
			// 전달받은 년, 월을 Calendar에 세팅
			cal.set(Calendar.YEAR, year);
		    cal.set(Calendar.MONTH, month);
		    cal.set(Calendar.DATE, 0);
		    
		    System.out.println("전달 : "+year+" : "+month);
		    System.out.println("date 확인 : "+cal.get(Calendar.DAY_OF_MONTH));
		    
		    // 해당 달의 마지막 날 구하기
		    int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		    System.out.println("달의 마지막 날 : "+endDay);
		    
		    // 해당 달의 첫번째 날의 요일 구하기
		    // 일요일 : 1, 토요일 : 7
		    cal.set(Calendar.DATE, 1); // date를 1일로 강제하여 첫째날 요일을 알 수 있다.
		    int startDay = cal.get(Calendar.DAY_OF_WEEK);
		    System.out.println("달의 첫째날 요일 : "+startDay);
		    
		    MakeDTO makeDTO = new MakeDTO();
		    makeDTO.setMonth(month);
		    makeDTO.setYear(year);
		    makeDTO.setEndDay(endDay);
		    makeDTO.setStartDay(startDay);
		    
		    return makeDTO;
		}

		// 달력 붙이기(다음달)
		public MakeDTO makePlus(String calYear, String calMonth) {
			Calendar cal = Calendar.getInstance(); // Calendar 클래스 사용 준비
			int month = Integer.parseInt(calMonth)+1;
			int year = Integer.parseInt(calYear);
	        System.out.println("month 값 : "+month);
			if(month > 12) {
	        	year = Integer.parseInt(calYear)+1;
	        	month = 1;
	        }else{
	        	System.out.println(month);
	        }
			
			// 전달받은 년, 월을 Calendar에 세팅
			cal.set(Calendar.YEAR, year);
		    cal.set(Calendar.MONTH, month);
		    cal.set(Calendar.DATE, 0);
		    
		    System.out.println("date 확인 : "+cal.get(Calendar.DAY_OF_MONTH));
		    
		    // 해당 달의 마지막 날 구하기
		    int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		    System.out.println("다음달 : "+year+" : "+month);
		    System.out.println("달의 마지막 날 : "+endDay);
		    
		    // 해당 달의 첫번째 날의 요일 구하기
		    // 일요일 : 1, 토요일 : 7
		    cal.set(Calendar.DATE, 1); // date를 1일로 강제하여 첫째날 요일을 알 수 있다.
		    int startDay = cal.get(Calendar.DAY_OF_WEEK);
		    System.out.println("달의 첫째날 요일 : "+startDay);
		    
		    MakeDTO makeDTO = new MakeDTO();
		    makeDTO.setMonth(month);
		    makeDTO.setYear(year);
		    makeDTO.setEndDay(endDay);
		    makeDTO.setStartDay(startDay);
		    
		    return makeDTO;
		}
	
	
}
