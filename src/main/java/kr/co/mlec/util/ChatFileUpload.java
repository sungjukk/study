package kr.co.mlec.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.UUID;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.mlec.dao.BoardDao;
import kr.co.mlec.vo.FileVO;

public class ChatFileUpload {
	
	public FileVO fileUpload(MultipartFile file) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd");
		String datePath = sdf.format(new Date());
		String savePath = "c://study" + datePath;
		
		File f = new File(savePath);
		
		if (!f.exists()) f.mkdirs();
		
			String oriFileName = file.getOriginalFilename();
			
			if (oriFileName != null && !oriFileName.equals("")) {
				String ext = "";
				int index = oriFileName.lastIndexOf(".");
				if (index != -1) {
					ext = oriFileName.substring(index);
				}
				String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + UUID.randomUUID().toString() + ext;
				FileVO fv = new FileVO();
				fv.setBoard_no(0);
				fv.setBoard_type(1);
				fv.setFilePath(datePath);
				fv.setOriName(oriFileName);
				fv.setSysName(saveFileName);
				System.out.println("등록된거야 만거야");
				file.transferTo(new File(savePath + "/" + saveFileName));
				return fv;	
			}
		return null;
	}
}
