package hos.semi.service;

import java.util.ArrayList;

import hos.semi.dao.StatDAO;
import hos.semi.dto.CategoryDTO;
import hos.semi.dto.IosDTO;

public class Calculator {

	//카테고리그래프
		public ArrayList<Double> category(ArrayList<Integer> ctgList,ArrayList<Integer> mList, String onselect) {
			
			ArrayList <Double> avgList = new ArrayList<>();

			//카테고리별 지출 퍼센트
			//1.전체 지출 총합
			int sum =0;
			for(int i=0;i<mList.size();i++) {
				sum+=mList.get(i);
			}
			System.out.println("sum:"+sum);
			StatDAO dao = null;
			//2.특정 카테고리에 해당하는 지출금액들
			//카테고리 리스트 (인덱스)
			
			for(int i=0;i<ctgList.size();i++) {
				int ctgIdx =ctgList.get(i);
				System.out.println("ctgIdx:"+ctgIdx);
				//특정 카테고리에 해당하는 지출금액 리스트
				dao = new StatDAO();
				ArrayList<IosDTO> ctgmList=dao.ctg(ctgIdx,onselect);
				System.out.println("ctgmList.size():"+ctgmList.size());
				
				//비율 : 특정카테고리에 해당하는 지출금액의 합/ 총지출금액 *100 (%)
				int cSum=0;
				for(int k=0;k<ctgmList.size();k++) {
					cSum += ctgmList.get(k).getIosM();
				}
				
				System.out.println("cSum:"+cSum);
				
				double avg = cSum*100/sum;
				System.out.println("avg:"+avg);		
				
				avgList.add(avg);
			}
			//map.put(subList, avgList);
			
			return avgList;
		}

		//카테고리 이름을 뽑아오기위한 메소드
		public ArrayList<String> categorySub(ArrayList<Integer> ctgList, ArrayList<Integer> mList) {

			ArrayList<String> subList = new ArrayList<>();
			
			for(int i=0;i<ctgList.size();i++) {
				int ctgIdx =ctgList.get(i);

				StatDAO dao = null;
				//특정 카테고리에 해당하는 카테고리 이름
				dao = new StatDAO();
				CategoryDTO name = dao.ctgSub(ctgIdx);

				String sub = name.getCtgSub();
			
				subList.add(sub);
			}
			return subList;
		}

		//=================================================
		//특정 요일별 통계값
			public ArrayList<Double> dotw(ArrayList<String> dayList, ArrayList<Integer> mList2, String onselect2) {
				ArrayList <Double> davgList = new ArrayList<>();

				//요일별 지출 퍼센트
				//1.전체 지출 총합
				int sum =0;
				for(int i=0;i<mList2.size();i++) {
					sum+=mList2.get(i);
				}
				System.out.println("sum2:"+sum);
				StatDAO dao = null;
				//2.특정 요일 해당하는 지출금액들
					//요일 리스트		
				for(int i=0;i<dayList.size();i++) {
					String day =dayList.get(i);
					System.out.println("day:"+day);
					//특정 요일에 해당하는 지출금액 리스트
					dao = new StatDAO();
					ArrayList<IosDTO> dotwMList=dao.dotwM(day,onselect2);
					System.out.println("dotwMList.size():"+dotwMList.size());
					
					//비율 : 특정카테고리에 해당하는 지출금액의 합/ 총지출금액 *100 (%)
					int dSum=0;
					for(int k=0;k<dotwMList.size();k++) {
						dSum += dotwMList.get(k).getIosM();
					}
					
					System.out.println("dSum:"+dSum);
					
					double avg = dSum*100/sum;
					System.out.println("avg:"+avg);		
					
					davgList.add(avg);
				}
				return davgList;
			}
	
}
