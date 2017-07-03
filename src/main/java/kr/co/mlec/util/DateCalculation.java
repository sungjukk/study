package kr.co.mlec.util;

import java.util.Date;

public class DateCalculation {
	private Date nowDate = new Date();
	
	public String DateCalculation(Date writeDate) throws Exception {
		long nDate = nowDate.getTime();
		long longDate = writeDate.getTime();
		long subtraction = nDate - longDate;
		int cDay = (int) (subtraction / (24 * 60 * 60 * 1000));
		int cHour = (int) (subtraction / (60 * 60 * 1000));
		int cMinute = (int) (subtraction / (60 * 1000));
		int cSeconds = (int) (subtraction / (1000));
		
		if (cDay >= 1) {
			return cDay + "일전";
		} else if (cHour >= 1) {
			return cHour + "시간전";
		} else if (cMinute >= 1) {
			return cMinute + "분전";
		} else if (cSeconds >= 1) {
			return cSeconds + "초전";
		}
		return "0초전";
	}
}
